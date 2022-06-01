# frozen_string_literal: true

FactoryBot.define do
  factory :core_shipment, class: 'Core::Shipment' do
    quantity { 10 }
    shipment_date { Time.now.as_core_time }
    description { 'Acme shipment' }
    notes { 'Shipment notes' }
    created { Time.now.as_core_time }

    association :order, factory: :core_order
    association :processor, factory: :core_user
    association :purchase_order, factory: :core_purchase_order
    association :user, factory: :core_user
  end
end
