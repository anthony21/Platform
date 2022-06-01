# frozen_string_literal: true

class Core::Reports::CountsByDatabaseReport
  attr_reader :start_at, :end_at

  def initialize(start_at: nil, end_at: nil)
    @start_at = start_at ? DateTime.parse(start_at) : 1.month.ago.beginning_of_day
    @end_at = end_at ? DateTime.parse(end_at).end_of_day : DateTime.now.end_of_day
  end

  def run
    counts = Core::Count.where(completed: @start_at..@end_at)
    counts = counts.group('selects->"$.database"', 'date(completed)').count

    (@start_at.to_date..@end_at.to_date).map do |date|
      {
        date: date.to_s,
        consumer: counts.fetch(['"Consumer"', date], 0),
        business: counts.fetch(['"Business"', date], 0),
        auto: counts.fetch(['"Auto"', date], 0)
      }
    end
  end

  def series
    [
      { name: 'Consumer', key: 'consumer' },
      { name: 'Business', key: 'business' },
      { name: 'Auto', key: 'auto' }
    ]
  end
end
