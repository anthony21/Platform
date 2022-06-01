# frozen_string_literal: true

class List < ApplicationRecord
  include Appendable
  include Auditable
  include Broadcastable
  include DataRequestable
  include Deletable
  include Emailable
  include Filterable
  include Geographical
  include ListTypeable
  include Omissible
  include Phoneable
  include Processable
  include RecordCountable
  include Searchable
  include Shippable
  include Statusable
  include Suppressible
  include Uploadable

  belongs_to :user, default: -> { Current.user }
  has_one :account, through: :user
  belongs_to :data_source, optional: true
  has_many :list_suppressions,
           class_name: 'Suppression',
           foreign_key: :suppression_list,
           dependent: :destroy

  validates :user, presence: true
  validates :name, presence: true

  def self.of(audience)
    list_count = Current.user.lists.count
    name = list_count.zero? ? audience.name : "#{audience.name} #{list_count + 1}"

    new(
      user: Current.user,
      audience:,
      name:,
      data_source: audience.data_source,
      filters: audience.filters,
      geography: audience.geography,
      omissions: audience.omissions,
      select_type: audience.select_type,
      phones: audience.phones,
      phone_type: audience.phone_type,
      dnc: audience.dnc,
      emails: audience.emails,
      suppression_lists: audience.suppression_lists,
      status: 'submitted'
    )
  end
end
