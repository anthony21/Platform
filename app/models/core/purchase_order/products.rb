# frozen_string_literal: true

module Core::PurchaseOrder::Products
  extend ActiveSupport::Concern

  included do
    serialize :products, JSON
  end

  def product_description
    products.map { |p| "#{p['quantity']} x #{p['item']}\n#{p['description']}" }.join("\n\n")
  end

  private

  def product_amount
    products.map { |p| p['amount'] }.sum
  end
end
