# frozen_string_literal: true

module Core::Order::OrderConfirmations
  extend ActiveSupport::Concern

  def confirm?(order_confirmation_params)
    ActiveRecord::Base.transaction do
      approval = order_confirmation_params.delete(:approval)

      if approval == 'no'
        update_status!(status: :rejected_by_client, notes: 'Order rejected ')
      else
        create_san(order_confirmation_params)

        order_confirmations.create!(
          order_confirmation_params.merge(
            ip: Current.ip_address,
            useragent: Current.user_agent,
            created: Current.core_time
          )
        )
        update_status!(status: :approved_by_client, notes: 'Order approved')
      end
    end
  end

  def create_san(order_confirmation_params)
    san_params = order_confirmation_params.extract!(
      :san, :expiration, :licensee, :authname, :authtitle, :exempt
    )

    Core::San.create!(san_params.merge(order: self, created: Current.core_time)) if san
  end
end
