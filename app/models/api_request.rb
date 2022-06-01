# frozen_string_literal: true

class ApiRequest < ApplicationRecord
  belongs_to :account

  serialize :body, JSON

  validates :account, presence: true
  validates :request_type, presence: true
  validates :body, presence: true
  validates :requested_at, presence: true
end
