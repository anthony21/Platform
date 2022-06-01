# frozen_string_literal: true

FactoryBot.define do
  factory :core_payroll_record, class: 'Core::PayrollRecord' do
    amount_paid { 0 }
    vendor_cost { 0 }
    po_amount { 30 }

    association :purchase_order, factory: :core_purchase_order
    order { purchase_order&.order }
    rep { order&.rep }
    date { purchase_order&.created }
  end
end
