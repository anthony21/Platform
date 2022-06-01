# frozen_string_literal: true

module List::Searchable
  extend ActiveSupport::Concern

  included do
    scope :search, -> (search) { where('name LIKE ?', "%#{search}%") if search.present? }
    scope :for_user, -> (user_filter) { where(user: Current.user) if user_filter == 'mine' }
  end
end
