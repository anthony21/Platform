# frozen_string_literal: true

module User::Roles
  extend ActiveSupport::Concern

  included do
    enum :role, %i(user admin)

    validates :role, presence: true
  end
end
