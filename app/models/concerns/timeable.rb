# frozen_string_literal: true

module Timeable
  extend ActiveSupport::Concern

  def time
    start = Time.now
    yield
    Time.now - start
  end
end
