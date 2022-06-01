# frozen_string_literal: true

FactoryBot.define do
  factory :core_payment, class: 'Core::Payment' do
    method_of_payment { 'CC' }
    reference_no { '' }
    amount { 800.00 }
    notes { 'Invoice payment' }
    created { Time.now.as_core_time }

    association :invoice, factory: :core_invoice
    association :submitted_by, factory: :core_user
  end
end
