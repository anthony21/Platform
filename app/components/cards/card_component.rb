# frozen_string_literal: true

class Cards::CardComponent < BaseComponent
  renders_one :expanded_content

  def initialize(
    title: nil, icon: nil, color: :gray, expandable: false, classes: nil, **options
  )
    @title = title
    @icon = icon
    @color = color
    @expandable = expandable
    @options = options
    @classes = @options.delete(:class) || classes
  end

  def expanded_hidden_id
    @expanded_hidden_id ||= SecureRandom.uuid
  end
end
