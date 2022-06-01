# frozen_string_literal: true

class FeatureComponent < BaseComponent
  def initialize(feature:)
    @feature = feature
  end

  def enabled?
    Feature.enabled?(@feature)
  end
end
