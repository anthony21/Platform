# frozen_string_literal: true

module List::Uploadable
  extend ActiveSupport::Concern

  included do
    has_one_attached :file

    serialize :column_mappings, JSON
    validate :column_mappings_are_present

    before_save -> { self.status = 'submitted' }, if: :uploaded_column_mappings_changed?
    after_save :reprocess_later, if: :reprocess?
  end

  def uploaded_column_mappings_changed?
    column_mappings_changed? && uploaded?
  end

  def reprocess?
    !id_previously_changed? && column_mappings_previously_changed? && uploaded?
  end

  def reprocess
    update(visualization: nil, status: 'processing')
    self.class.delete_snowflake_list(id)
    process
  end

  def reprocess_later
    List::ReprocessJob.perform_later(id)
  end

  def first_line
    if Rails.application.config.active_storage.service == :amazon
      S3::Query.new(file).first_line
    else
      file.open(&:first)
    end
  end

  def available_match_types
    List::MatchType.new(column_mappings).available_match_types
  end

  private

  def column_mappings_are_present
    return unless uploaded? && available_match_types.blank?

    errors.add(:column_mappings, I18n.t('lists.errors.column_mappings'))
  end
end
