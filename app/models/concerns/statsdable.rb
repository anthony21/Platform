# frozen_string_literal: true

module Statsdable
  extend ActiveSupport::Concern

  class_methods do
    def time(method, stat)
      alias_method "untimed_#{method}", method

      define_method method do
        statsd.time(stat) { __send__("untimed_#{method}") }
      end
    end
  end

  def statsd
    @statsd ||= Rails.application.config.statsd
  end
end
