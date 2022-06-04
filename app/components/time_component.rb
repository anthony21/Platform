# frozen_string_literal: true

class TimeComponent < ViewComponent::Base
  delegate :local_time, to: :helpers

  def initialize(at:)
    @time = at
  end

  def call
    local_time(@time, '%B %d, %Y at %l:%M %p')
  end
end
