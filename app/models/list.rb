class List < ApplicationRecord
    belongs_to :user, default: -> { Current.user }
    has_one :account, through: :user
end