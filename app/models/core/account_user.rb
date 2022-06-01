# frozen_string_literal: true

class Core::AccountUser < Core::Record
  self.table_name = 'account_users'

  belongs_to :user, class_name: 'Core::User'
  belongs_to :account, class_name: 'Core::Account'
end
