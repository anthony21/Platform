# frozen_string_literal: true

class Core::User < Core::Record
  include Syncable

  self.table_name = 'users'

  has_many :account_users, class_name: 'Core::AccountUser'
  has_many :accounts, through: :account_users

  scope :employees, -> { where(employee: true) }
  scope :processors, -> { employees.where(role_id: 9) }

  def uo_user
    @uo_user ||= User.find_by(core_user: self)
  end

  def account
    accounts.first
  end

  def primary?
    account&.primary_user == self
  end

  def name
    [first_name, last_name].compact.join(' ')
  end

  def initials
    [first_name.try(:first), last_name.try(:first)].compact.join
  end

  def gravatar_url
    email_md5 = Digest::MD5.hexdigest(email.downcase)
    "https://www.gravatar.com/avatar/#{email_md5}.jpg?d=identicon"
  end
end
