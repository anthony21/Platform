# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    email { Faker::Internet.unique.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { 'testtest' }
    role { :admin }

    core_user { association :core_user, email: }
    account

    after(:create) do |user, _|
      if user.core_user.present? && user.account.core_account.blank?
        core_account = create(:core_account, primary_user: user.core_user)
        user.account.update!(core_account:)
      end
    end

    factory :account_manager do
      features do
        {
          account_management: true,
          shipments: true
        }
      end
    end
  end
end
