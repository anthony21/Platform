# frozen_string_literal: true

class StringSet < ActiveRecord::Type::Value
  def cast(value)
    values = value.is_a?(String) ? value.split(',') : value
    Set.new(values).to_a
  end

  def serialize(value)
    Set.new(value).to_a.join(',')
  end
end
