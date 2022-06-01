# frozen_string_literal: true

class Core::Reports::OrderReport
  attr_reader :start_at, :end_at

  def initialize(start_at: nil, end_at: nil)
    @start_at = start_at ? DateTime.parse(start_at).beginning_of_day : 1.month.ago
    @end_at = end_at ? DateTime.parse(end_at).end_of_day : DateTime.now.end_of_day
  end

  def run
    orders = Core::OrderStatusLog.completed.where(date: start_at..end_at).group(:user_id).count
    orders = orders.map do |user_id, order_count|
      user = Core::User.find(user_id)
      {
        name: user.name,
        initials: user.initials,
        gravatar_url: user.gravatar_url,
        value: order_count
      }
    end
    orders.sort { |a, b| b[:value] <=> a[:value] }
  end
end
