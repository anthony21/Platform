# frozen_string_literal: true

FactoryBot.define do
  factory :core_payroll_item, class: 'Core::PayrollItem' do
    rep_name { Faker::Name.name }
    client { Faker::Company.name }
    date { Time.now.as_core_time }
    payment_method { 'CC' }
    ref { 'pi_3KbZmYI9BfdoQj1z1uY9jUGr' }
    classification { 'LG' }
    amount_paid { 100 }
    commissionable_amount { 100 }
    commission_percentage { 0.17 }
    commission { 17 }
    po_amount { 0 }
    previously_paid { 0 }
    is_adjustment { false }
    updated { Time.now.as_core_time }

    association :order, factory: :core_order
    association :purchase_order, factory: :core_purchase_order
    association :pay_period, factory: :core_pay_period

    rep { order&.rep }
    partner { order&.partner }
  end
end
