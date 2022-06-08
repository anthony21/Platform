# frozen_string_literal: true

module Account::RecordCountable
  extend ActiveSupport::Concern

  included do
    has_many :record_transactions
    has_many :lists, through: :users
  end

  def available_records
    total_records - used_records
  end

  def total_records
    record_transactions.sum(:record_count)
  end

<<<<<<< HEAD

=======
  def used_records
    lists.where(list_type: 'audience').sum(:record_count)
  end
>>>>>>> origin/main
end
