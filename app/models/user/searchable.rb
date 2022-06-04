# frozen_string_literal: true

module User::Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, lambda { |search|
                     where(
                       'first_name LIKE :q OR last_name LIKE :q OR email LIKE :q',
                       q: "%#{search}%"
                     )
                   }
  end
end
