# frozen_string_literal: true

class DateComponent < BaseComponent
  delegate :local_time, to: :helpers

  def initialize(on:)
    @date = on
  end

  def call
    local_time(@date, '%b %d')
  end
end
