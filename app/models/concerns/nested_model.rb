# frozen_string_literal: true

module NestedModel
  extend ActiveSupport::Concern
  include ActiveModel::Model
  include ActiveModel::Attributes

  class_methods do
    def root_key_val
      @root_key
    end

    def root_key(key)
      @root_key = key
    end

    def load(data)
      return new if data.blank?

      parsed_data = Oj.load(data)
      parsed_data = parsed_data[root_key_val] if root_key_val.present?

      new(parsed_data)
    end

    def dump(object)
      object.to_json
    end
  end

  def to_json(*_args)
    data = {}

    attribute_names.each do |name|
      type = self.class.attribute_types[name]
      value = attributes[name]
      data[name] = type.serialize(value)
    end

    data = { self.class.root_key_val => data } if self.class.root_key_val.present?

    Oj.dump(data)
  end
end
