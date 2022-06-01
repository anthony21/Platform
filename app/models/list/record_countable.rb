# frozen_string_literal: true

module List::RecordCountable
  extend ActiveSupport::Concern

  included do
    validates :record_count, presence: true, numericality: { greater_than: 0 }, if: :audience?
    validate :account_has_records_available, on: :create
    validate :audience_has_records_available, on: :create
  end

  def account_has_records_available
    return unless audience? && record_count.present?
    return if user.account.available_records >= record_count

    errors.add(:record_count, I18n.t('lists.errors.not_enough_account_records'))
  end

  def audience_has_records_available
    return unless audience? && record_count.present?

    audience.preview_available_records
    return if audience.count >= record_count

    errors.add(:record_count, I18n.t('lists.errors.not_enough_audience_records'))
  end
end
