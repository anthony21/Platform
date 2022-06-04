# frozen_string_literal: true

module CurrentRequest
  extend ActiveSupport::Concern

  included do
    before_action -> { Current.request = request }
  end
end
