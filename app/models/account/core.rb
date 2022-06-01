# frozen_string_literal: true

module Account::Core
  extend ActiveSupport::Concern

  included do
    belongs_to :core_account, class_name: 'Core::Account', optional: true
    has_many :orders, through: :core_account
    has_many :invoices, through: :core_account
  end
end
