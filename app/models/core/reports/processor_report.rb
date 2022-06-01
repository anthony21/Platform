# frozen_string_literal: true

class Core::Reports::ProcessorReport
  attr_reader :start_at, :end_at, :user

  def initialize(user_id: nil, start_at: nil, end_at: nil)
    @start_at = start_at ? DateTime.parse(start_at) : 1.month.ago.beginning_of_day
    @end_at = end_at ? DateTime.parse(end_at).end_of_day : DateTime.now.end_of_day
    @user = user_id ? Core::User.find(user_id) : Core::User.processors.first
  end

  def run
    purchase_orders = Core::PurchaseOrderStatusLog.completed
    purchase_orders = purchase_orders.where(date: start_at..end_at, user_id: @user.id)
    purchase_orders = purchase_orders.group('date(date)').count

    counts = Core::CountStatusLog.completed.where(created: start_at..end_at, user_id: @user.id)
    counts = counts.group('date(created)').count

    (@start_at.to_date..@end_at.to_date).map do |date|
      {
        date: date.to_s,
        purchase_orders: purchase_orders.fetch(date, 0),
        counts: counts.fetch(date, 0)
      }
    end
  end

  def series
    [
      { name: 'Purchase Orders', key: 'purchase_orders' },
      { name: 'Counts', key: 'counts' }
    ]
  end
end
