# frozen_string_literal: true

class Current < ActiveSupport::CurrentAttributes
  attribute :user, :account, :request

  def user=(user)
    super
    self.account = user&.account
  end

  def version
    ENV['APPLICATION_VERSION'] || 'v0.0.0'
  end

  def revision
    ENV['GIT_SHA'] || '00000000'
  end

  def core_time
    Time.now.as_core_time
  end

  def ip_address
    request&.remote_ip
  end

  def user_agent
    request&.user_agent
  end
end
