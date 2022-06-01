# frozen_string_literal: true

class ToggleComponent < ViewComponent::Base
  def initialize(form:, field:, enabled: false, id: nil)
    @form = form
    @field = field
    @enabled = enabled
    @id = id
  end
end
