# frozen_string_literal: true

module Featureable
  extend ActiveSupport::Concern

  class_methods do
    def feature(name, **before_action_options)
      before_action(**before_action_options) do
        redirect_to :root, alert: I18n.t('unauthorized') unless Feature.enabled?(name)
      end
    end
  end
end
