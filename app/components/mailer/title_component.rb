# frozen_string_literal: true

class Mailer::TitleComponent < ViewComponent::Base
  def initialize(title:)
    @title = title
  end
end
