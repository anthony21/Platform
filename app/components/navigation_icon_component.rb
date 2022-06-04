# frozen_string_literal: true

class NavigationIconComponent < BaseComponent
  def initialize(name:, text: nil)
    @name = name
    @text = text
  end
end
