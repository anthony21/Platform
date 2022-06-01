# frozen_string_literal: true

module User::Nameable
  extend ActiveSupport::Concern

  included do
    validates :first_name, presence: true
    validates :last_name, presence: true
  end

  def display_name
    full_name.blank? ? email : full_name
  end

  def full_name
    [first_name, last_name].join(' ').strip
  end
end
