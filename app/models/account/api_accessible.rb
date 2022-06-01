# frozen_string_literal: true

module Account::ApiAccessible
  extend ActiveSupport::Concern

  included do
    has_many :api_requests, dependent: :destroy
    has_secure_token :api_token
  end
end
