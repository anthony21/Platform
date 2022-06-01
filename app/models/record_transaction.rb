# frozen_string_literal: true

class RecordTransaction < ApplicationRecord
  audited except: :updated_at, associated_with: :account

  belongs_to :account

  validates :record_count, presence: true, numericality: { greater_than: 0 }
end
