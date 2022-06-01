class CreatePayrollRecords < ActiveRecord::Migration[7.0]
  def change
    create_table :payroll_records do |t|
      t.integer :order_id
      t.integer :po_id
      t.integer :payment_id
      t.integer :payroll_item_id
      t.integer :rep
      t.datetime :date, precision: nil
      t.decimal :amount_paid, precision: 10, scale: 2, null: false
      t.decimal :po_amount, precision: 10, scale: 2
      t.decimal :vendor_cost, precision: 10, scale: 2, null: false
      t.string :notes
    end
  end
end
