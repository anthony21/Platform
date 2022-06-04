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

  def current?
    Current.account == self
  end
end
