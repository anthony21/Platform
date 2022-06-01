# frozen_string_literal: true

class Core::Reports::FlaggedPoReport
  attr_reader :start_at, :end_at

  def initialize(start_at: nil, end_at: nil)
    @start_at = start_at ? DateTime.parse(start_at).beginning_of_day : 1.month.ago
    @end_at = end_at ? DateTime.parse(end_at).end_of_day : DateTime.now.end_of_day
  end

  def run
    all_purchase_orders = Core::PurchaseOrder.where(created: start_at..end_at)
      .group('date(created)')
      .count

    flagged_purchase_orders = Core::PurchaseOrder.where(created: start_at..end_at)
      .includes(:status_logs)
      .merge(Core::PurchaseOrderStatusLog.flagged)
      .references(:status_logs)
      .group('date(created)')
      .count

    trend_values = []

    data = (@start_at.to_date..@end_at.to_date).map do |date|
      date_all_count = all_purchase_orders.fetch(date, 0)
      date_flagged_count = flagged_purchase_orders.fetch(date, 0)

      trend_values << date_flagged_count

      {
        date: date.to_s,
        all: date_all_count,
        flagged: date_flagged_count
      }
    end

    trend = LinearRegression.new(trend_values).trend

    data.each_with_index do |d, index|
      d[:trend] = trend[index]
    end

    data
  end

  def series
    [
      { name: 'All', key: 'all' },
      { name: 'Flagged', key: 'flagged' },
      { name: 'Trend', key: 'trend' }
    ]
  end
end
