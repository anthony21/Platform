# frozen_string_literal: true

FactoryBot.define do
  factory :core_user, class: 'Core::User' do
    transient do
      account { nil }
    end

    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    created { 1.day.ago.as_core_time }
    employee { false }

    after(:create) do |user, evaluator|
      evaluator.account&.account_users&.create!(user:)
    end
  end
end
