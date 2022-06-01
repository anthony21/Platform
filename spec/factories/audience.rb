# frozen_string_literal: true

FactoryBot.define do
  factory :audience do
    name { Faker::FunnyName.name }
    count_results do
      { count: 245_000_000 }
    end

    data_source
    user
  end
end
