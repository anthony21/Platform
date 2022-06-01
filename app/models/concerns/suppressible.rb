# frozen_string_literal: true

module Suppressible
  extend ActiveSupport::Concern
  include LazyIds

  included do
    has_many :suppressions, as: :suppressible, dependent: :destroy
    has_many :suppression_lists, through: :suppressions

    lazy_ids :suppressions
    lazy_ids :suppression_lists
  end

  def suppressions?
    suppression_lists.present?
  end
end
