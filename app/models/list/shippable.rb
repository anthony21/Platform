# frozen_string_literal: true

module List::Shippable
  extend ActiveSupport::Concern

  included do
    belongs_to :core_shipment, class_name: 'Core::Shipment', optional: true
  end
end
