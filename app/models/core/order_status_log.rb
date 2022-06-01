# frozen_string_literal: true

class Core::OrderStatusLog < Core::Record
  self.table_name = 'order_status_log'

  enum :status, Core::Order.statuses

  belongs_to :user, class_name: 'Core::User'
  belongs_to :order, class_name: 'Core::Order'
end
