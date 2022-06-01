# frozen_string_literal: true

module Filterable
  extend ActiveSupport::Concern

  included do
    serialize :filters, Filters
  end

  def filters = super.tap { |f| f.data_source = data_source }
end
