# frozen_string_literal: true

module Core::Order::Status
  extend ActiveSupport::Concern

  included do
    enum :status, {
      new_order: 0,
      ready_for_manager: 10,
      denied_by_manager: 11,
      approved_by_manager: 12,
      ready_for_accounting: 20,
      denied_by_accounting: 21,
      approved_by_accounting: 22,
      ready_for_client: 30,
      rejected_by_client: 31,
      approved_by_client: 32,
      awaiting_payment: 40,
      ready_for_processing: 50,
      processing: 54,
      flagged: 59,
      completed: 100,
      contract_cancelled: 200,
      dead: 1000
    }

    has_many :status_logs, class_name: 'Core::OrderStatusLog', foreign_key: :order_id

    after_commit :send_completion_mail_later, on: :update
  end

  def update_status!(status:, notes: '', user: nil)
    ActiveRecord::Base.transaction do
      status_logs.create!(
        date: Current.core_time,
        user: user || Current.user.core_user,
        notes:,
        status:
      )
      update!(status:)
    end
  end

  private

  def send_completion_mail_later
    return unless completed?

    Core::OrderMailer.with(order: self).completed.deliver_later
  end
end
