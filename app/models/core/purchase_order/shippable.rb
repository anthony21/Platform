# frozen_string_literal: true

module Core::PurchaseOrder::Shippable
  extend ActiveSupport::Concern

  def ship(shipment_params, user_ids, file)
    ActiveRecord::Base.transaction do
      user_ids.each do |user_id|
        shipment = shipments.build(shipment_params)
        shipment.order = order
        shipment.user = Core::User.find(user_id)
        shipment.processor = Current.user.core_user
        shipment.created = Current.core_time
        shipment.save!

        shipment.ship(file)
      end

      update!(processor: Current.user.core_user)
      update_status!(status: :completed, notes: 'Data shipped')

      order.update_status!(status: :completed, notes: 'All POs completed') if order.complete?
    end
  end
end
