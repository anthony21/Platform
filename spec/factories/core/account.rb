# frozen_string_literal: true

FactoryBot.define do
  factory :core_account, class: 'Core::Account' do
    company_name { 'Acme Corporation' }
    address { '1461 Lawrence Drive, 2nd Floor' }
    city { 'Thousand Oaks' }
    state { 'CA' }
    zip { '91320' }
    created { Time.now.as_core_time }
    match_key { 'acmecorporation' }

    association :primary_user, factory: :core_user
    association :rep, factory: :core_user

    after(:create) do |account|
      account.account_users.create!(user: account.primary_user)
    end
  end
end
