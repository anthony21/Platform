# frozen_string_literal: true

module User::Accountable
  extend ActiveSupport::Concern

  included do
    belongs_to :account

    accepts_nested_attributes_for :account

    validates :account, presence: true

    after_initialize :build_account, unless: :account
  end
end
