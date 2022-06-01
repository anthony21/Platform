# frozen_string_literal: true

module CoreTimeable
  extend ActiveSupport::Concern

  class_methods do
    def core_time(attribute_name, new_attribute_name)
      define_method new_attribute_name do
        Time.parse("#{public_send(attribute_name).strftime('%Y-%m-%dT%H:%M:%S')}-08:00")
      end
    end
  end
end
