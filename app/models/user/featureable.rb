# frozen_string_literal: true

module User::Featureable
  extend ActiveSupport::Concern

  included do
    serialize :features, JSON
  end

  def feature_enabled?(feature)
    has_feature?(feature) && features[feature.to_s]
  end

  def has_feature?(feature)
    features.try(:key?, feature.to_s)
  end

  def enable_feature(feature, enabled: true)
    self.features ||= {}

    return if current? && feature == 'super_admin'

    features[feature] = enabled
    save
  end
end
