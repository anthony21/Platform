# frozen_string_literal: true

class Core::PurchaseOrder < Core::Record
  include CoreTimeable
  include Payroll
  include Products
  include Shippable
  include Status

  self.table_name = 'purchase_orders'

  belongs_to :order, class_name: 'Core::Order'
  belongs_to :processor, class_name: 'Core::User', foreign_key: :processor, optional: true
  has_many :shipments, class_name: 'Core::Shipment'
  belongs_to :vendor, class_name: 'Core::Vendor'
  belongs_to :partner, class_name: 'Core::Partner'
  has_one :payroll_record, class_name: 'Core::PayrollRecord', foreign_key: :po_id

  serialize :shipping_address, Address

  core_time :created, :created_at
  core_time :completed, :completed_at

  scope :completed_at, -> (completed_at) { completed.where(completed: completed_at) }

  def display_id
    "#{order_id}-#{sequence_id}"
  end
end
