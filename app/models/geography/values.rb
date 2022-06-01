# frozen_string_literal: true

module Geography::Values
  extend ActiveSupport::Concern

  class_methods do
    def values(field)
      raw_values[field]
    end

    def display_name(field, key)
      values(field)[key] || key
    end

    private

    def raw_values
      @raw_values ||= Oj.load(File.read(Rails.root.join('config', 'geography.json')))
    end
  end
end
