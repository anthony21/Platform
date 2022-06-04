# frozen_string_literal: true

module Loggable
  extend ActiveSupport::Concern

  class_methods do
    def log(message, level = :info)
      Rails.logger.public_send(level, format_message(message))
    end

    private

    def format_message(message)
      ["[#{name}]", message].join(' ')
    end
  end

  def log(message, level = :info)
    self.class.log(message, level)
  end
end
