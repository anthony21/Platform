# frozen_string_literal: true

module SystemNotices
  extend ActiveSupport::Concern

  included do
    before_action :set_system_notices
  end

  def set_system_notices
    @system_notices = SystemNotice.all
  end
end
