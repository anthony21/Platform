# frozen_string_literal: true

class Tables::RowComponent < BaseComponent
  renders_many :cells, lambda { |classes: nil, colspan: 1|
    Tables::CellComponent.new(url: @url, classes:, colspan:)
  }

  def initialize(url: nil)
    @url = url
  end
end
