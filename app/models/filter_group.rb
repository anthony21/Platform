# frozen_string_literal: true

class FilterGroup
  attr_reader :data_source
  attr_accessor :group_type, :filters

  def self.group_key?(key)
    %w(and or).include?(key)
  end

  def initialize(group_type, serialized_filters)
    @group_type = group_type
    @filters = serialized_filters.map { |f| Filters.deserialize_filter(f) }
  end

  def data_source=(data_source)
    @filters.each { |f| f.data_source = data_source }
    @data_source = data_source
  end

  def as_json
    serialized_filters = filters.map(&:as_json).compact
    return if serialized_filters.blank?

    [group_type, filters.map(&:as_json)]
  end

  def field_key = nil

  def group? = true

  def fields
    filters.map(&:fields)
  end

  def ==(other)
    other.try(:group_type) == group_type && other.try(:filters) == filters
  end
end
