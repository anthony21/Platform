# frozen_string_literal: true

module Scoped
  extend ActiveSupport::Concern

  class_methods do
    def scoped(collection)
      before_action do
        @account = Account.find(params[:account_id]) if params[:account_id].present?
      end

      before_action do
        redirect_unauthorized unless scope_allowed?
      end

      define_method collection do
        @account.try(collection) || collection.to_s.singularize.capitalize.constantize.all
      end
    end
  end

  private

  def scope_allowed?
    return true if Feature.enabled? :account_management

    # Only users with the account management feature can view unscoped.
    return false if params[:account_id].blank?

    Current.account == @account
  end
end
