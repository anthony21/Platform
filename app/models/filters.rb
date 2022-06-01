# frozen_string_literal: true

class Filters
  include Enumerable

  attr_reader :data_source, :filters

  delegate :each, :size, to: :filters

  class << self
    def load(data)
      return new if data.blank?

      new(Oj.load(data))
    end

    def dump(object)
      object.to_json
    end

    def deserialize_filter(serialized_filter)
      return if serialized_filter.blank?

      key, values = serialized_filter

      if FilterGroup.group_key?(key)
        FilterGroup.new(key, values)
      else
        Filter.new(key, values)
      end
    end
  end

  def initialize(serialized_filters = nil)
    @filters = Array(serialized_filters).map { |f| self.class.deserialize_filter(f) }.compact
  end

  def data_source=(data_source)
    @filters.each { |f| f.data_source = data_source }
    @data_source = data_source
  end

  def as_json
    filters.map(&:as_json).compact
  end

  def fields
    filters.map(&:fields).flatten
  end

  def [](field_key)
    all_filters.find { |filter| filter.field_key == field_key }
  end

  def ==(other)
    other.try(:filters) == filters
  end

  private

  def all_filters
    filters.map(&:filters).flatten
  end
end
