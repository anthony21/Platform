# frozen_string_literal: true

class Lists::VisualizationComponent < BaseComponent
  delegate :format_breakdown, :breakdown_rows, to: :helpers

  def initialize(list:)
    @list = list
  end

  def data_source
    List.append_data_source
  end
end
