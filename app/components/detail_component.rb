# frozen_string_literal: true

class DetailComponent < BaseComponent
  def initialize(name: nil, url: nil, selection_buttons: false)
    @name = name
    @url = url
    @selection_buttons = selection_buttons
  end
end
