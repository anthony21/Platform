# frozen_string_literal: true

class UnauthenticatedPageComponent < ViewComponent::Base
  include ComponentHelper

  renders_one :subtitle

  def initialize(title:)
    @title = title
  end
end
