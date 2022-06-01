# frozen_string_literal: true

class Core::Reports::TrendReport
  attr_reader :start_at, :end_at

  def initialize(start_at: nil, end_at: nil)
    @start_at = start_at ? DateTime.parse(start_at) : 1.month.ago.beginning_of_day
    @end_at = end_at ? DateTime.parse(end_at).end_of_day : 1.day.ago.end_of_day
  end

  def run
    purchase_orders = Core::PurchaseOrderStatusLog.completed.where(date: start_at..end_at)
    purchase_orders = purchase_orders.group('date(date)').count

    counts = Core::CountStatusLog.completed.where(created: start_at..end_at)
    counts = counts.group('date(created)').count

    values = []

    data = (@start_at.to_date..@end_at.to_date).map do |date|
      date_purchase_orders = purchase_orders.fetch(date, 0)
      date_counts = counts.fetch(date, 0)
      value = date_purchase_orders + date_counts
      values << value

      { date: date.to_s, value: }
    end

    trend = LinearRegression.new(values).trend

    data.each_with_index do |d, index|
      d[:trend] = trend[index]
    end

    data
  end

  def series
    [
      { name: 'Counts + Purchase Orders', key: 'value' },
      { name: 'Trend', key: 'trend' }
    ]
  end
end
