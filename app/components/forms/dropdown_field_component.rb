# frozen_string_literal: true

class Forms::DropdownFieldComponent < BaseComponent
  def initialize(
    form:, field:, label:, options:, required: false, data: nil, value: nil, prompt: nil
  )
    @form = form
    @field = field
    @label = label
    @options = options
    @required = required
    @data = data
    @value = value.nil? ? @form.object.public_send(@field) : value
    @prompt = prompt
  end
end
