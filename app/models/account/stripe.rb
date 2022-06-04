# frozen_string_literal: true

module Account::Stripe
  extend ActiveSupport::Concern

  def stripe_id
    super || create_stripe_customer!
  end

  def create_stripe_customer!
    fail 'Currenly only supported for CORE transactions' if core_account.blank?

    customer = Stripe::Customer.create(
      address: {
        city: core_account.city,
        country: 'US',
        line1: core_account.address,
        line2: core_account.address2,
        postal_code: core_account.zip,
        state: core_account.state
      },
      email: core_account.primary_user.email,
      name:
    )
    update!(stripe_id: customer.id)
    customer.id
  end
end
