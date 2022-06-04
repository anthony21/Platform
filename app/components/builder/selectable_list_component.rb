# frozen_string_literal: true

class Builder::SelectableListComponent < BaseComponent
  def initialize(elements:, name: nil, tabs: true, selected_value: nil)
    @name = name
    @elements = elements
    @tabs = tabs
    @selected_value = selected_value
  end

  def selected?(element)
    @selected_value == element[:value]
  end
end
