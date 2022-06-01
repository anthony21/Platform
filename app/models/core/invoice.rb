# frozen_string_literal: true

class Core::Invoice < Core::Record
  include Status
  include Stripe

  self.table_name = 'invoice'

  belongs_to :order, class_name: 'Core::Order'
  has_one :account, through: :order, foreign_key: :client
  has_one :primary_user, through: :account, foreign_key: :primary_user
  has_many :payments, class_name: 'Core::Payment'

  serialize :products, JSON
end
