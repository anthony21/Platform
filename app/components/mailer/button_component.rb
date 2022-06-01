# frozen_string_literal: true

class Mailer::ButtonComponent < ViewComponent::Base
  def initialize(text: nil, url: nil)
    @text = text
    @url = url
  end
end
