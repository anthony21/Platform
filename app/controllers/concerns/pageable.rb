# frozen_string_literal: true

module Pageable
  extend ActiveSupport::Concern

  included do
    include Pagy::Backend
  end
end
