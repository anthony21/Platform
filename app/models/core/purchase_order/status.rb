# frozen_string_literal: true

module Core::PurchaseOrder::Status
  extend ActiveSupport::Concern

  included do
    enum :status, {
      new_purchase_order: 0,
      ready_to_process: 1,
      out_to_vendor: 2,
      received_from_vendor: 3,
      processing: 4,
      completed: 5,
      dead: 6
    }, default: :new_purchase_order

    has_many :status_logs, class_name: 'Core::PurchaseOrderStatusLog', foreign_key: :po_id

    scope :active, -> { where('status < ?', statuses['completed']) }
  end

  def update_status!(status:, notes: nil, user: nil)
    ActiveRecord::Base.transaction do
      status_logs.create!(
        date: Current.core_time,
        user: user || Current.user.core_user,
        notes:,
        status:
      )
      assign_attributes(status:)
      assign_attributes(completed: Current.core_time) if status == :completed
      save!
    end
  end
end
