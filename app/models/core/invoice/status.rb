# frozen_string_literal: true

module Core::Invoice::Status
  extend ActiveSupport::Concern

  included do
    enum :status, {
      new_invoice: 0,
      open_for_payment: 10,
      scheduled: 11,
      ready_to_be_scheduled: 12,
      waiting_custom_payment: 13,
      blocked: 19,
      partial_payment_received: 50,
      paid: 100,
      processing_payment: 101,
      archived: 500,
      refunded: 1000,
      charged_back: 1001,
      cancelled: 1100,
      dead: 2000,
      duplicate: 3000
    }

    has_many :status_logs, class_name: 'Core::InvoiceStatusLog'
  end

  def update_status!(status:, notes:, user: nil)
    ActiveRecord::Base.transaction do
      update!(status:)

      status_logs.create!(
        date: Current.core_time,
        notes:,
        status:,
        user: user || Current.user.core_user
      )
    end
  end
end
