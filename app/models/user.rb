# frozen_string_literal: true

class User < ApplicationRecord
  include Securable
  include Recoverable
  include Accountable
  include Auditable
  include Core
  include Featureable
  include Nameable
  include Roles
  include Searchable

  has_many :lists, dependent: :destroy

  def current?
    self == Current.user
  end
end
