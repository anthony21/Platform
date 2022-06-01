class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.integer :invoice_id, null: false
      t.integer :subscription_id
      t.integer :submitted_by, null: false
      t.integer :trans_check_id
      t.integer :trans_credit_id
      t.string :method_of_payment, limit: 20, null: false
      t.string :reference_no, limit: 50, null: false
      t.decimal :amount, precision: 10, scale: 2, null: false
      t.text :notes, null: false
      t.datetime :created, null: false
      t.datetime :export_date
    end
  end
end
