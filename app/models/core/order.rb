# frozen_string_literal: true

class Core::Order < Core::Record
  include Address
  include FulfillmentType
  include OrderConfirmations
  include PurchaseOrders
  include Status

  self.table_name = 'orders'

  belongs_to :partner, class_name: 'Core::Partner'
  belongs_to :account, class_name: 'Core::Account', foreign_key: :client
  belongs_to :rep, class_name: 'Core::User', foreign_key: :rep
  belongs_to :term, class_name: 'Core::Term', foreign_key: :terms

  has_many :purchase_orders, class_name: 'Core::PurchaseOrder'
  has_many :invoices, class_name: 'Core::Invoice'
  has_many :order_confirmations, class_name: 'Core::OrderConfirmation'

  has_one :san_record, class_name: 'Core::San', foreign_key: :orderid

  serialize :products, JSON
  serialize :discount, JSON

  def complete?
    purchase_orders.active.count.zero?
  end

  def net_agreement?
    payment_terms == 'net_terms' || payment_terms == 'process_before_payment'
  end

  def payment_options
    payoptions.split(',')
  end
end
