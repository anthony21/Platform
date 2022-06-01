# frozen_string_literal: true

module User::UrbanOutletsEmail
  extend ActiveSupport::Concern

  URBAN_OUTLETS_DOMAINS = %w(
    
  ).freeze

  included do
    validate :not_urban_outlets_email, on: :create
  end

  private

  def not_urban_outlets_email
    return unless account.new_record?
    return unless URBAN_OUTLETS_DOMAINS.any? { |e| email.include?(e) }

    errors.add(:base, I18n.t('users.views.email_error'))
  end
end
