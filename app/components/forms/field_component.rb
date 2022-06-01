# frozen_string_literal: true

class Forms::FieldComponent < BaseComponent
  def initialize(
    form:, field:, field_type: :text, label: nil, help_text: nil, required: false,
    label_help_text: nil, **field_options
  )
    @form = form
    @field = field
    @field_type = field_type
    @label = label || @field.to_s.humanize
    @label_help_text = label_help_text
    @help_text = help_text
    @required = required
    @field_options = field_options
  end

  def errors
    @form.object.try(:errors).try(:[], @field)
  end

  def input
    @form.public_send(field_type, @field, @field_options.merge(class: field_classes))
  end

  def field_type
    @field_type == :text_area ? :text_area : "#{@field_type}_field"
  end

  def field_classes
    helpers.field_classes(has_errors: errors.present?)
  end

  def field_attributes
    {
      form: @form,
      field: @field,
      label: @label,
      help_text: @help_text,
      required: @required,
      label_help_text: @label_help_text
    }
  end
end
