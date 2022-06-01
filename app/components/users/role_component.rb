# frozen_string_literal: true

class Users::RoleComponent < ViewComponent::Base
  def initialize(user:)
    @user = user
  end

  def call
    @user.role.capitalize
  end
end
