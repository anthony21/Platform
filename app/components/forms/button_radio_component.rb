# frozen_string_literal: true

class Forms::ButtonRadioComponent < BaseComponent
  def initialize(form:, field:, label:, options:, required: false)
    @form = form
    @field = field
    @label = label
    @options = options
    @required = required
  end

  def selected_classes
    %w(
      active:bg-blue
      bg-blue
      dark:active:bg-blue
      dark:bg-blue
      dark:disabled:bg-gray-400
      dark:hover:bg-blue
      dark:text-gray-900
      disabled:bg-gray-400
      disabled:text-gray-600
      focus:ring-blue
      hover:bg-blue
      text-white
    ).join(' ')
  end

  def deselected_classes
    %w(bg-gray-100 dark:bg-gray-800 dark:hover:bg-gray-600 hover:bg-gray-300).join(' ')
  end

  def selected?(option)
    option[:value] == @form.object.try(@field)
  end
end
