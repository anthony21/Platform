# frozen_string_literal: true

module Core::Invoice::Stripe
  extend ActiveSupport::Concern

  class_methods do
    def process_checkout_session(checkout_session)
      metadata = checkout_session[:metadata]
      user_id = metadata[:user_id]
      invoice_id = metadata[:invoice_id]

      find(invoice_id).process_payment_later(checkout_session[:payment_intent], user_id)
    end
  end

  def process_payment_later(payment_intent_id, user_id)
    Core::Invoice::ProcessPaymentJob.perform_later(id, payment_intent_id, user_id)
  end

  def process_payment(payment_intent_id, user)
    ActiveRecord::Base.transaction do
      payments.create!(
        amount: amount_due,
        method_of_payment: 'CC',
        reference_no: payment_intent_id,
        created: Current.core_time,
        notes: 'Paid through Stripe',
        submitted_by: user
      )

      update_status!(
        status: amount_due == amount ? :paid : :partial_payment_received,
        notes: 'Paid through Stripe',
        user:
      )

      if paid?
        order.update_status!(
          status: :ready_for_processing,
          notes: 'Invoice paid',
          user:
        )
      end
    end

    # TODO: Send email
  end

  def line_items
    products.map do |product|
      {
        price_data: {
          currency: 'usd',
          unit_amount: (product['amount'] * 100).to_i,
          product_data: {
            name: product['item'],
            description: product['description']
          }
        },
        quantity: 1
      }
    end
  end
end
