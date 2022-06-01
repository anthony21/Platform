# frozen_string_literal: true

module Core::Order::Address
  extend ActiveSupport::Concern

  included do
    serialize :billing_address, Address
    serialize :shipping_address, Address
  end
end
