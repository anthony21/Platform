# frozen_string_literal: true

module Core::Order::FulfillmentType
  extend ActiveSupport::Concern

  def fulfillment_type
    types = product_fulfillment_types

    case types.size
    when 0 then 'unknown'
    when 1 then types.first
    else 'mixed'
    end
  end

  def in_house?
    fulfillment_type == 'in_house'
  end

  private

  def product_fulfillment_types
    types = Set.new

    products&.each do |product|
      product['fields'].each do |field|
        next unless field['label'] == 'Fulfillment Type'

        types << field['value']
      end
    end

    types
  end
end
