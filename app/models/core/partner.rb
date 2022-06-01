# frozen_string_literal: true

class Core::Partner < Core::Record
  self.table_name = 'partners'

  belongs_to :company, class_name: 'Core::Company'
  has_many :orders, class_name: 'Core::Order'
  has_many :purchase_orders, class_name: 'Core::PurchaseOrder'

  def full_address
    Address.new(address:, address2:, city:, state:, zip:)
  end
end
