# frozen_string_literal: true

class SystemNoticesComponent < BaseComponent
  def initialize(notices:)
    @notices = notices
  end

  def render?
    @notices.present?
  end
end
