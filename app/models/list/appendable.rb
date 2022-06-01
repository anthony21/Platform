# frozen_string_literal: true

module List::Appendable
  extend ActiveSupport::Concern

  included do
    serialize :appends, JSON
    serialize :visualization, JSON

    belongs_to :original_list, class_name: 'List', optional: true

    after_save :visualize_later, if: :appends_previously_changed?
  end

  class_methods do
    def append_data_source
      DataSource.active.find_by!(name: 'Consumer')
    end

    def append(original_list)
      List.new(
        user: Current.user,
        name: "#{original_list.name} (Appended)",
        appends: original_list.appends,
        original_list:,
        list_type: 'append',
        column_mappings: original_list.column_mappings
      )
    end
  end

  def visualize?
    uploaded? && ready? && append_dedupe_field_key.present?
  end

  def visualize_later
    List::VisualizeJob.perform_later(id)
  end

  def visualize
    return if visualization.present?

    breakdowns = {}

    visualization_field_keys.map do |field_key|
      data = Data.new(visualization_data_request(field_key))
      breakdowns.merge!(data.results.breakdowns)
    end

    update(visualization: { breakdowns: })
  end

  def visualization_data_request(field_key)
    {
      data_source: List.append_data_source.id,
      dedupe: [append_dedupe_field_key],
      append: id,
      breakdowns: [field_key]
    }
  end

  def append_data_request
    {
      data_source: List.append_data_source.id,
      dedupe: [append_dedupe_field_key],
      append: original_list_id,
      output_fields: append_output_fields.map(&:key)
    }
  end

  def append_output_fields
    appends.map do |append_key|
      append = List.append_data_source.appends.with_key(append_key)
      append.output_fields
    end.flatten
  end

  private

  def append_dedupe_field_key
    return 'email' if available_match_types.include?(:email)
    return 'wireless_priority' if available_match_types.include?(:phone)
    return 'name_address_zip' if available_match_types.include?(:individual)
    return 'last_address_zip' if available_match_types.include?(:household)
    return 'address_zip' if available_match_types.include?(:address)
  end

  def visualization_field_keys
    appends.map do |append_key|
      append = List.append_data_source.appends.with_key(append_key)
      append.visualization_fields
    end.flatten.map(&:key)
  end
end
