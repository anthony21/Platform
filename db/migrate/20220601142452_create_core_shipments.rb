class CreateCoreShipments < ActiveRecord::Migration[7.0]
  def change
    create_table :shipments do |t|
      t.integer :order_id
      t.integer :purchase_order_id
      t.integer :user_id
      t.integer :processor_id
      t.integer :quantity
      t.text :file_location
      t.text :description
      t.text :notes
      t.datetime :shipment_date
      t.datetime :created
    end
  end
end
