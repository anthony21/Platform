# frozen_string_literal: true

module Core::Order::PurchaseOrders
  extend ActiveSupport::Concern

  included do
    after_save :create_purchase_order, if: :create_purchase_order?
  end

  def shipping_method
    Array(products&.first.try(:[], 'shipping_method')).join(',')
  end

  private

  def create_purchase_order?
    saved_change_to_attribute?(:status) && ready_for_processing? && in_house?
  end

  def create_purchase_order
    user = status_logs.last.user

    ActiveRecord::Base.transaction do
      purchase_order = purchase_orders.create!(
        sequence_id: next_purchase_order_sequence_id,
        partner:,
        shipping_address:,
        products: purchase_order_products,
        notes: product_notes,
        amount: 0,
        neededby: Current.core_time,
        shipping_method:,
        created: Current.core_time
      )
      update_status!(
        status: :processing,
        notes: "PO# #{purchase_order.display_id} created",
        user:
      )
      purchase_order.update_status!(
        status: :new_purchase_order,
        notes: 'Purchase order created automatically for in-house order',
        user:
      )
      purchase_order.update_status!(
        status: :ready_to_process,
        notes: 'Automatic release',
        user:
      )
    end

    # TODO: Send email that PO is ready to process
  end

  def next_purchase_order_sequence_id
    purchase_orders.count + 1
  end

  def purchase_order_products
    po_products = []

    products.each do |product|
      details = []

      product['fields'].each do |field|
        next if field['label'] == 'Fulfillment Type'

        details << "#{field['label']}:\n#{field['value']}"

        product['services'].each do |service|
          details << service
        end
      end

      po_products << {
        'item' => product['item'],
        'description' => product['description'],
        'details' => details.join("\n\n"),
        'quantity' => product['quantity'],
        'amount' => 0,
        'price' => 0,
        'notes' => ''
      }
    end

    po_products
  end

  def product_notes
    products.map { |product| product['notes'] }.join("\n")
  end
end
