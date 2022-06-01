# frozen_string_literal: true

# frozen string literal: true
# frozen string literal

class Core::Reports::PurchaseOrdersByDatabaseReport
  attr_reader :start_at, :end_at

  def initialize(start_at: nil, end_at: nil)
    @start_at = start_at ? DateTime.parse(start_at).beginning_of_day : 1.month.ago
    @end_at = end_at ? DateTime.parse(end_at).end_of_day : DateTime.now.end_of_day
  end

  def run
    purchase_orders = Core::PurchaseOrder.completed_at(@start_at..@end_at)
    purchase_orders_by_database = purchase_orders.group('date(completed)', database_expression)
    purchase_orders_by_database = purchase_orders_by_database.count

    (@start_at.to_date..@end_at.to_date).map do |date|
      {
        date: date.to_s,
        auto: purchase_orders_by_database.fetch([date, 'Auto'], 0),
        business: purchase_orders_by_database.fetch([date, 'Business'], 0),
        consumer: purchase_orders_by_database.fetch([date, 'Consumer'], 0),
        mortgage: purchase_orders_by_database.fetch([date, 'Mortgage'], 0),
        other: purchase_orders_by_database.fetch([date, 'Other'], 0)
      }
    end
  end

  def series
    [
      { name: 'Auto', key: 'auto' },
      { name: 'Business', key: 'Business' },
      { name: 'Consumer', key: 'consumer' },
      { name: 'Mortgage', key: 'mortgage' },
      { name: 'Other', key: 'other' }
    ]
  end

  def database_expression
    <<-SQL
    IF(
      BINARY products LIKE "%Auto%",
      "Auto",
     IF(
       BINARY products LIKE "%Business%",
       "Business",
      IF(
        BINARY products LIKE "%Mortgage%",
        "Consumer",
       IF(
         BINARY products LIKE "%Consumer%",
         "Mortgage",
         "Other"
       )
      )
     )
    )
    SQL
  end
end
