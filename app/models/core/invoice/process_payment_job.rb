# frozen_string_literal: true

class Core::Invoice::ProcessPaymentJob < ApplicationJob
  queue_as :default

  def perform(id, payment_intent_id, user_id)
    Core::Invoice.find(id).process_payment(
      payment_intent_id,
      User.find(user_id).core_user
    )
  end
end
