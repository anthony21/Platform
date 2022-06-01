# frozen_string_literal: true

module Core::Account::Syncable
  extend ActiveSupport::Concern
  include Loggable

  class SyncError < StandardError; end

  class_methods do
    def sync
      Core::Account.find_each(&:sync_later)
    end
  end

  def sync_later
    Core::SyncAccountJob.perform_later(id)
  end

  def sync!
    log "Creating UO account for CORE account #{id}"

    ActiveRecord::Base.transaction do
      uo_account = existing_uo_account || Account.new(name: company_name.presence || 'Unknown')
      uo_account.update!(core_account: self)

      account_users.where(removed: false).find_each do |account_user|
        account_user.user.sync(uo_account)
      end

      uo_account
    end
  end

  private

  def existing_uo_account
    uo_account = existing_uo_accounts.first
    return uo_account if uo_account&.core_account.blank? || uo_account.core_account == self

    fail SyncError, 'UO account already linked to another CORE account'
  end

  def existing_uo_accounts
    uo_users = User.where(email: account_users.where(removed: false).map { |au| au.user.email })
    uo_accounts = uo_users.map(&:account).uniq

    fail SyncError, 'Users belong to multiple VIA accounts' if uo_accounts.size > 1

    uo_accounts
  end
end
