# frozen_string_literal: true

class Core::Shipment < Core::Record
  include Core::Shipment::Shippable

  self.table_name = 'shipments'

  belongs_to :purchase_order, class_name: 'Core::PurchaseOrder'
  belongs_to :user, class_name: 'Core::User'
  belongs_to :order, class_name: 'Core::Order'
  belongs_to :processor, class_name: 'Core::User'
  has_one :list, foreign_key: :core_shipment_id
  has_one :account, through: :order
  has_one :primary_user, through: :account

  validates :quantity, presence: true
  validates :shipment_date, presence: true
  validates :description, presence: true
  validates :notes, presence: true
end
