class CreateCoreOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.integer :client
      t.integer :partner_id
      t.decimal :amount, precision: 10, scale: 2
      t.string :payoptions
      t.string :payment_terms, limit: 50
      t.datetime :created
      t.datetime :updated
      t.integer :status
      t.boolean :emails
      t.integer :count
      t.string :classification, limit: 5
      t.string :shipping_method, limit: 100
      t.text :shipping_address
      t.text :billing_address
      t.text :discount
      t.text :notes
      t.text :products
      t.string :fulfillment_type, limit: 30
    end
  end
end
