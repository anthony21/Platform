# frozen_string_literal: true

module MultiValueModel
  extend ActiveSupport::Concern

  include SharedValueModel

  class_methods do
    def find_values(ids)
      find(ids).pluck(*value_columns).map { |s| s.compact.join(' ') }
    end
  end

  def value
    self.class.value_columns.map { |s| public_send(s) }.compact.join(' ')
  end

  def to_filter_group
    {
      and: field_map.map do |model_attribute, field|
        value = public_send(model_attribute)
        next if value.blank?

        { key: field, values: [value] }
      end.compact
    }
  end
end
