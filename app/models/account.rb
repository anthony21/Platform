# frozen_string_literal: true

class Account < ApplicationRecord
  include Usable
  include ApiAccessible
  include Core
  include RecordCountable
  include Searchable
  include Stripe


  audited except: :updated_at
  has_associated_audits

  validates :name, presence: true

  has_secure_token :invite_token

  scope :activity, lambda { |account|
    account
      .associated_audits
      .where.not(auditable_type: %w(User RecordTransaction))
      .order(created_at: :desc, id: :desc)
  }

  def current?
    Current.account == self
  end
end
