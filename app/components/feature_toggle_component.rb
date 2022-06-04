# frozen_string_literal: true

class FeatureToggleComponent < ViewComponent::Base
  def initialize(user:, feature:)
    @user = user
    @feature = feature
  end

  def id
    @feature[:id]
  end

  def enabled?
    Feature.enabled?(id, @user)
  end
end
