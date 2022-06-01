# frozen_string_literal: true

class EmptyStateComponent < ViewComponent::Base
  def initialize(with_header: false)
    @with_header = with_header
  end
end
