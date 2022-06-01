# frozen_string_literal: true

FactoryBot.define do
  factory :core_order, class: 'Core::Order' do
    amount { 2760 }
    payoptions { 'credit,check,custom' }
    payment_terms { 'net_terms' }
    created { Time.now.as_core_time }
    updated { Time.now.as_core_time }
    status { :new_order }
    subscription { false }
    san { false }
    emails { false }
    notes { 'Acme order' }
    discount { { amount: 123, description: 'instant rebate' } }
    billing_address do
      {
        address: {
          name: 'John Smith',
          company: 'Acme Secondary',
          address: '123 Bill St',
          address2: '',
          city: 'Pasadena',
          state: 'CA',
          zip: '91101',
          country: 'United States',
          phone: '(123) 456-7890',
          email: ''
        }
      }
    end
    shipping_address do
      {
        address: {
          name: 'John Smith',
          company: 'Acme Secondary',
          address: '123 Ship Ave',
          address2: '',
          city: 'Pasadena',
          state: 'CA',
          zip: '91101',
          country: 'United States',
          phone: '(123) 456-7890',
          email: ''
        }
      }
    end
    products do
      [
        {
          item: 'List',
          description: 'Specialty Database',
          quantity: 18_400,
          amount: 2760,
          price: 0.15,
          notes: 'Product notes',
          shipping_method: 'ListGiant.com',
          id: '2',
          class: 'LG',
          months: '',
          fields: [
            {
              label: 'Fulfillment Type',
              value: 'in_house',
              visibleCore: false,
              visiblePay: false,
              multiOption: false
            },
            {
              label: 'Trade Name',
              value: 'Weekly New Refinance',
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            },
            {
              label: 'Geography',
              value: 'State: CA',
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            },
            {
              label: 'List On Output',
              value: 'First Name, Last Name, Mailing Address (City, State, Zip, Zip4, CRRT, ' \
                     'County), Mortgage Amount, Purchase Amount (where available), Closing Date, ' \
                     'Date on File, Lender Name',
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            },
            {
              label: 'Selects',
              value: "SFDU Homeowners\r\nLender Name 100%",
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            },
            {
              label: 'Offer Description',
              value: 'Broker',
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            },
            {
              label: 'Phones',
              value: 'No Phones',
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            },
            {
              label: 'Phone Type',
              value: 'NA',
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            },
            {
              label: 'Emails',
              value: 'No Emails',
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            },
            {
              label: 'Email Validation',
              value: 'NA',
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            },
            {
              label: 'Email Validation Type',
              value: 'NA',
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            },
            {
              label: 'Delivery File Format',
              value: 'CSV',
              visibleCore: true,
              visiblePay: true,
              multiOption: false
            }
          ],
          services: [],
          autorenew: false
        }
      ]
    end

    association :partner, factory: :core_partner
    association :account, factory: :core_account
    association :rep, factory: :core_user
    association :term, factory: :core_term
  end
end
