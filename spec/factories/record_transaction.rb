# frozen_string_literal: true

FactoryBot.define do
  factory :record_transaction do
    record_count { 100_000 }

    account
  end
end
