# frozen_string_literal: true

class Tables::CellComponent < BaseComponent
  def initialize(url: nil, **options)
    @url = url
    @options = options
  end

  def classes
    @options[:classes]
  end

  def colspan
    @options[:colspan]
  end
end
