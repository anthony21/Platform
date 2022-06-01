# frozen_string_literal: true

module Geographical
  extend ActiveSupport::Concern

  included do
    serialize :geography, Geography

    validates_associated :geography
  end
end
