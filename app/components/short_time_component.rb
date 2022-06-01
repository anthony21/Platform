# frozen_string_literal: true

class ShortTimeComponent < BaseComponent
  delegate :local_time, to: :helpers

  def initialize(at:)
    @time = at
  end

  def call
    local_time(@time, '%m/%d/%y %l:%M %p')
  end
end
