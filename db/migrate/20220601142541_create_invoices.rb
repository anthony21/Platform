class CreateInvoices < ActiveRecord::Migration[7.0]
  def change
    create_table :invoice do |t|
      t.integer :order_id, null: false
      t.integer :status, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.decimal :amount_due, precision: 10, scale: 2, null: false
      t.string :payment_terms, limit: 50, null: false
      t.datetime :due
      t.datetime :date_shipped
      t.datetime :created, null: false
      t.datetime :updated, null: false
      t.text :billing_address, null: true
      t.text :notes, null: true
      t.text :legalese, null: true
      t.text :products, null: true
    end
  end
end
