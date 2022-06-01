# frozen_string_literal: true

class Tables::TableComponent < BaseComponent
  renders_many :header_cells, Tables::HeaderCellComponent
  renders_many :rows, Tables::RowComponent

  def initialize(filterable: false, pagy: nil, entry_name: nil)
    @filterable = filterable
    @pagy = pagy
    @entry_name = entry_name
  end
end
