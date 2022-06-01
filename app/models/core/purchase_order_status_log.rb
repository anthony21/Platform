# frozen_string_literal: true

class Core::PurchaseOrderStatusLog < Core::Record
  self.table_name = 'purchase_order_status_log'

  enum :status, Core::PurchaseOrder.statuses

  belongs_to :user, class_name: 'Core::User'
  belongs_to :purchase_order, class_name: 'Core::PurchaseOrder', foreign_key: :po_id

  scope :flagged, -> { where(notes: 'PO flagged.') }
end
