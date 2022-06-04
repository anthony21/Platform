# frozen_string_literal: true

module Account::Usable
  extend ActiveSupport::Concern

  included do
    has_many :users, dependent: :destroy
  end
end
