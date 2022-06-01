# frozen_string_literal: true

class Filter
  attr_accessor :data_source, :field_key, :values

  def initialize(field_key, values)
    @field_key = field_key
    @values = values
  end

  def fields = [field]

  def filters = [self]

  def group? = false

  def each_value(&)
    values.each(&)
  end

  def as_json
    return if values.blank?

    [field_key, values]
  end

  def field
    data_source.fields[field_key]
  end

  def ==(other)
    other.try(:field_key) == field_key && other.try(:values) == values
  end
end
