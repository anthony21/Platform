# frozen_string_literal: true

class Core::Reports::PurchaseOrderReport
  attr_reader :start_at, :end_at

  def initialize(start_at: nil, end_at: nil)
    @start_at = start_at ? DateTime.parse(start_at).beginning_of_day : 1.month.ago
    @end_at = end_at ? DateTime.parse(end_at).end_of_day : DateTime.now.end_of_day
  end

  def run
    purchase_orders = Core::PurchaseOrderStatusLog.completed.where(date: start_at..end_at)
    purchase_orders = purchase_orders.group(:user_id).count
    purchase_orders = purchase_orders.map do |user_id, purchase_order_count|
      user = Core::User.find(user_id)
      {
        name: user.name,
        initials: user.initials,
        gravatar_url: user.gravatar_url,
        value: purchase_order_count
      }
    end
    purchase_orders.sort { |a, b| b[:value] <=> a[:value] }
  end
end
