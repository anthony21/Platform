# frozen_string_literal: true

module SharedValueModel
  extend ActiveSupport::Concern

  def as_json(_options)
    [id.to_s, value]
  end
end
