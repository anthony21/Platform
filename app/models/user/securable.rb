# frozen_string_literal: true

module User::Securable
  extend ActiveSupport::Concern

  included do
    include User::Emailable
    extend User::Validations::ProtectedValidator::HelperMethods

    validates_protected_attributes :password, secure: true

    has_secure_password
  end
end
