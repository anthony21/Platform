# frozen_string_literal: true

class AvatarComponent < BaseComponent
  delegate :gravatar_image, to: :helpers

  def initialize(user:, with_name: false)
    @user = user
    @with_name = with_name
  end
end
