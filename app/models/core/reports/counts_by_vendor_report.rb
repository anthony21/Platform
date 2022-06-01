# frozen_string_literal: true

class Core::Reports::CountsByVendorReport
  attr_reader :start_at, :end_at

  def initialize(start_at: nil, end_at: nil)
    @start_at = start_at ? DateTime.parse(start_at) : 1.month.ago.beginning_of_day
    @end_at = end_at ? DateTime.parse(end_at).end_of_day : DateTime.now.end_of_day
  end

  def run
    counts = Core::Count.where(completed: @start_at..@end_at)
    counts = counts.group('selects->"$.vendor"', 'date(completed)').count

    (@start_at.to_date..@end_at.to_date).map do |date|
      {
        date: date.to_s,
        in_house: counts.fetch(['"Inhouse"', date], 0),
        vendor: counts.fetch(['"Vendor"', date], 0)
      }
    end
  end

  def series
    [
      { name: 'In-House', key: 'in_house' },
      { name: 'Vendor', key: 'vendor' }
    ]
  end
end
