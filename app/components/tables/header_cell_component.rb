# frozen_string_literal: true

class Tables::HeaderCellComponent < BaseComponent
  def initialize(name:, **options)
    @name = name
    @options = options
  end

  def classes
    @options[:classes]
  end
end
