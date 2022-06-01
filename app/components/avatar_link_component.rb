# frozen_string_literal: true

class AvatarLinkComponent < BaseComponent
  def initialize(user:, account: nil, **options)
    @user = user
    @account = account
    @options = options
  end
end
