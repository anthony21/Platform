# frozen_string_literal: true

class Core::PayrollRecord < Core::Record
  self.table_name = 'payroll_records'

  belongs_to :order, class_name: 'Core::Order'
  belongs_to :purchase_order, class_name: 'Core::PurchaseOrder', foreign_key: :po_id
  belongs_to :payment, class_name: 'Core::Payment', optional: true
  belongs_to :payroll_item, class_name: 'Core::PayrollItem', optional: true
  belongs_to :rep, class_name: 'Core::User', foreign_key: :rep
end
