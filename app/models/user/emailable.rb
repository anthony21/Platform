# frozen_string_literal: true

module User::Emailable
  extend ActiveSupport::Concern

  included do
    validates :email,
              presence: true,
              email: { mode: :strict, require_fqdn: true },
              uniqueness: { case_sensitive: false }
  end
end
