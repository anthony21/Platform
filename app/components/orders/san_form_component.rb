# frozen_string_literal: true

class Orders::SanFormComponent < BaseComponent
  delegate :field_classes, to: :helpers

  def initialize(san_order:, form:, last_nonexempt_san: {})
    @san_order = san_order
    @form = form
    @last_nonexempt_san = last_nonexempt_san
  end

  def render?
    @san_order
  end
end
