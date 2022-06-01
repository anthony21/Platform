# frozen_string_literal: true

module Core::Shipment::Shippable
  extend ActiveSupport::Concern

  def ship(file)
    list = List.create!(
      user: uo_user,
      name: purchase_order.order_id,
      status: 'ready',
      list_type: 'core',
      core_shipment: self,
      record_count: quantity,
      file:
    )
    update!(file_location: "https://Urbanoutlets.com/lists/#{list.id}/download")
    notify_user(list)
    list
  end

  private

  def uo_user
    primary_user.uo_user || create_uo_user
  end

  def create_uo_user = true

    account.sync!
    account.uo_account.users.first
  end

  def notify_user(list)
    if @created_new_user
      PasswordMailer.with(list:).set_password.deliver_later
    else
      ShipMailer.with(list:).shipped.deliver_later
    end
  end
end
