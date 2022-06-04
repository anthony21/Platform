# frozen_string_literal: true

class PurchaseOrders::CardComponent < BaseComponent
  def initialize(purchase_order:)
    @purchase_order = purchase_order
  end
end
