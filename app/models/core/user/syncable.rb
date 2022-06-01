# frozen_string_literal: true

module Core::User::Syncable
  extend ActiveSupport::Concern
  include Loggable

  class SyncError < StandardError; end

  def sync(uo_account)
    log "Creating uo user for CORE user #{id}"
    update_existing_user || create_new_user(uo_account)
  end

  private

  def update_existing_user
    existing_user = User.find_by(email: clean_email)
    return if existing_user.blank?

    if existing_user.core_user.present? && existing_user.core_user != self
      fail SyncError, 'Already linked to another user'
    end

    existing_user.update(core_user: self) && existing_user
  end

  def create_new_user(uo_account)
    user = User.new(
      account: uo_account,
      core_user: self,
      email: clean_email,
      first_name: first_name.presence || 'Unknown',
      last_name: last_name.presence || 'Unknown',
      role: primary? ? :admin : :user,
      password: SecureRandom.uuid
    )
    log "Failed to save user #{id}: #{user.errors.full_messages}" unless user.save
    user.generate_reset_password_token!
    user
  end

  def clean_email
    @clean_email ||= email.delete(' ').split(/[,;]/).first.strip.gsub('mailto:', '')
  end
end
