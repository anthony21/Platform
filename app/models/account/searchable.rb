# frozen_string_literal: true

module Account::Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, ->(search) { where('name LIKE :q', q: "%#{search}%") }
  end
end
