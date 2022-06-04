# frozen_string_literal: true

class Builder::ErrorMessageComponent < BaseComponent
  def initialize(errors:)
    @errors = errors
  end
end
