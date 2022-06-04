# frozen_string_literal: true

module User::Core
  extend ActiveSupport::Concern

  included do
    belongs_to :core_user, class_name: 'Core::User', optional: true
  end
end
