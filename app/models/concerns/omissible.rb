# frozen_string_literal: true

module Omissible
  extend ActiveSupport::Concern

  included do
    serialize :omissions, JSON
    after_initialize :set_omissions
    before_validation :set_omissions
  end

  def omit?(field_key)
    omissions.include?(field_key)
  end

  private

  def set_omissions
    self.omissions ||= []
  end
end
