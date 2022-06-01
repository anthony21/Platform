# frozen_string_literal: true

FactoryBot.define do
  factory :core_pay_period, class: 'Core::PayPeriod' do
    start_date { '2022-03-01 00:00:00' }
    end_date { '2022-03-31 00:00:00' }
    run_date { '2022-04-03 00:00:00' }
    payment_date { '2022-04-15 00:00:00' }
    description { 'March 2022 Commissions' }
  end
end
