# frozen_string_literal: true

FactoryBot.define do
  factory :core_purchase_order, class: 'Core::PurchaseOrder' do
    transient do
      database { 'Consumer' }
    end
    amount { 1000 }
    neededby { 1.day.from_now.as_core_time }
    created { Time.now.as_core_time }
    products do
      [
        {
          item: 'List',
          description: "US #{database} Masterfile",
          quantity: 10_000,
          amount: 800,
          price: 0.08,
          notes: '',
          shipping_method: 'ListGiant.com',
          id: '2',
          class: 'LG',
          months: '',
          autorenew: false,
          details: [
            'Geography: Nationwide',
            'List On Output: Email',
            'Selects: Cool dudes',
            'Offer Description: All emails for cool dudes',
            'Phones: No Phones',
            'Phone Type: NA',
            'Emails: 100% Emails',
            'Email Validation: Yes',
            'Email Validation Type: Acquisition',
            'Delivery File Format: CSV'
          ].join("\n")
        }
      ]
    end
    sequence_id { 1 }

    association :order, factory: :core_order
    association :vendor, factory: :core_vendor
    association :partner, factory: :core_partner
    association :processor, factory: :core_user
  end
end
