# frozen_string_literal: true

module CoreAuthorization
  extend ActiveSupport::Concern

  class_methods do
    def authorize(&)
      before_action :redirect_unauthorized, unless: -> { authorized?(instance_eval(&)) }
    end
  end

  def authorized?(account_id)
    return true if Feature.enabled?(:account_management)
    return false if Current.account.core_account_id != account_id

    Feature.enabled?(:account_admin)
  end
end
