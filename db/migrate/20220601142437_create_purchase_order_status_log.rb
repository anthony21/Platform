class CreatePurchaseOrderStatusLog < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_order_status_logs do |t|
      t.integer :po_id
      t.integer :user_id
      t.datetime :date
      t.string :status, limit: 20
      t.text :notes, limit: 42949672
      t.text :attachments
    end
  end
end
