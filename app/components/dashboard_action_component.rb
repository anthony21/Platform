# frozen_string_literal: true

class DashboardActionComponent < BaseComponent
  def initialize(title:, url:, image:, index:, description:, icon:)
    @title = title
    @url = url
    @image = image
    @index = index
    @description = description
    @icon = icon
  end
end
