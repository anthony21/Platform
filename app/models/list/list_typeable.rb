# frozen_string_literal: true

module List::ListTypeable
  extend ActiveSupport::Concern

  included do
    before_validation :set_list_type
  end

  def set_list_type
    self.list_type ||= audience.present? ? 'audience' : 'uploaded'
  end

  def core?
    list_type == 'core'
  end

  def uploaded?
    list_type == 'uploaded'
  end

  def audience?
    list_type == 'audience'
  end
end
