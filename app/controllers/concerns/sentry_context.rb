# frozen_string_literal: true

module SentryContext
  extend ActiveSupport::Concern

  included do
    before_action :set_sentry_context
  end

  private

  def set_sentry_context
    return unless Rails.env.production?

    Sentry.set_user(id: Current.user&.id)
    Sentry.set_extras(params: params.to_unsafe_h, url: request.url)
  end
end
