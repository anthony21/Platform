# frozen_string_literal: true

class Core::OrderConfirmation < Core::Record
  belongs_to :order, class_name: 'Core::Order'
  belongs_to :user, class_name: 'Core::User', default: -> { Current.user.core_user }

  validates :name, :job_title, presence: true, length: { minimum: 3 }
end
