# frozen_string_literal: true

FactoryBot.define do
  factory :core_invoice, class: 'Core::Invoice' do
    status { :open_for_payment }
    amount { 1000 }
    amount_due { 1000 }
    payment_terms { 'Prepayment' }
    due { 1.day.from_now.as_core_time }
    created { Time.now.as_core_time }
    updated { Time.now.as_core_time }
    products do
      [
        {
          item: 'List',
          description: 'US Consumer Masterfile',
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

    association :order, factory: :core_order
  end
end
