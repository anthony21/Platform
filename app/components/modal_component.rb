# frozen_string_literal: true

class ModalComponent < BaseComponent
  def initialize(id:, **options)
    @id = id
    @options = options
  end
end
