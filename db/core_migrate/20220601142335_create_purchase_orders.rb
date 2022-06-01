class CreatePurchaseOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :purchase_orders do |t|
      t.integer :order_id
      t.integer :vendor_id
      t.integer :processor
      t.integer :partner_id
      t.integer :sequence_id
      t.decimal :amount, precision: 10, scale: 2
      t.integer :status
      t.datetime :neededby
      t.string :po
      t.string :currentpo
      t.datetime :created
      t.datetime :updated
      t.datetime :completed
      t.datetime :export_date
      t.text :shipping_address
      t.text :products
      t.text :notes
      t.text :shipping_method
      t.boolean :is_flagged
    end
  end
end
