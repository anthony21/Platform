# frozen_string_literal: true

FactoryBot.define do
  factory :core_count, class: 'Core::Count' do
    selects { {} }
    created { Current.core_time }
    updated { Current.core_time }
    completed { Current.core_time }

    association :user, factory: :core_user
    association :processor, factory: :core_user
  end
end
