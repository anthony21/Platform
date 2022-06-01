# frozen_string_literal: true

class Core::Account < Core::Record
  include Syncable

  self.table_name = 'accounts'

  belongs_to :primary_user, class_name: 'Core::User', foreign_key: :primary_user
  has_many :account_users, class_name: 'Core::AccountUser', foreign_key: :account_id
  has_many :users, through: :account_users
  belongs_to :rep, class_name: 'Core::User', foreign_key: :rep_id

  has_many :orders, class_name: 'Core::Order', foreign_key: :client
  has_many :invoices, through: :orders
  has_many :sans, through: :orders, source: :san_record

  def uo_account
    @uo_account ||= Account.find_by(core_account: self)
  end

  def full_address
    Address.new(address:, address2:, city:, state:, zip:)
  end

  def last_nonexempt_san
    sans.joins(:order)
      .where(exempt: false, orders: { san: true })
      .where(Core::Order.arel_table[:status].gteq(Core::Order.statuses['approved_by_client']))
      .where(Core::San.arel_table[:expiration].gt(Time.now))
      .order(created: :desc)
      .limit(1)
      .first || {}
  end
end
