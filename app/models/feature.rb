# frozen_string_literal: true

class Feature
  FEATURES = {
    super_admin: {
      name: 'Super admin',
      rule: :off
    },
    account_admin: {
      name: 'Account admin',
      role: :admin
    },
    user_management: {
      name: 'User management',
      role: :admin
    },
    products: {
      name: 'Product management',
      rule: :off
    },
    account_management: {
      name: 'Account management',
      rule: :off
    },
    count_timings: {
      name: 'Display count timings',
      rule: :off
    },
    download_list: {
      name: 'Download lists',
      rule: :off
    },
    shipments: {
      name: 'Ship purchase orders in UO',
      rule: :off
    },
    appends: {
      name: 'Appends',
      rule: :off
    },
    verbose: {
      name: 'Verbose view',
      rule: :off
    }
  }.freeze

  class << self
    def all
      FEATURES.map do |k, v|
        v[:id] = k
        v
      end
    end

    def enabled?(id, user = Current.user)
      has_feature = user.try(:has_feature?, id)
      return user.feature_enabled?(id) if has_feature

      rule_enabled?(id, user)
    end

    private

    def rule_enabled?(id, user)
      feature = FEATURES[id.to_sym]
      return false if feature.blank?

      return user&.role == feature[:role].to_s if feature[:role].present?

      feature[:rule] == :on
    end
  end
end
