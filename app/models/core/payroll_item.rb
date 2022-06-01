# frozen_string_literal: true

class Core::PayrollItem < Core::Record
  self.table_name = 'payroll_items'

  belongs_to :order, class_name: 'Core::Order'
  belongs_to :purchase_order, class_name: 'Core::PurchaseOrder', foreign_key: :po_id
  belongs_to :partner, class_name: 'Core::Partner'
  belongs_to :pay_period, class_name: 'Core::PayPeriod'
  belongs_to :rep, class_name: 'Core::User', foreign_key: :rep
end
