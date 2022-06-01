# frozen_string_literal: true

module BreakDownable
  extend ActiveSupport::Concern

  included do
    serialize :breakdowns, JSON
    after_initialize :set_breakdowns
    before_validation :set_breakdowns
  end

  def break_down?(field_key)
    breakdowns.include?(field_key)
  end

  private

  def set_breakdowns
    self.breakdowns ||= []
  end
end
