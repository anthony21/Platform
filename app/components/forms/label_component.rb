# frozen_string_literal: true

class Forms::LabelComponent < ViewComponent::Base
  def initialize(form:, field:, required: false, label: nil, help_text: nil)
    @form = form
    @field = field
    @required = required
    @label = label
    @help_text = help_text
  end
end
