class CreatePayrollItems < ActiveRecord::Migration[7.0]
  def change
    create_table :payroll_items do |t|
      t.integer :order_id
      t.integer :po_id
      t.integer :partner_id
      t.integer :pay_period_id
      t.integer :rep
      t.string :rep_name, limit: 100, null: false
      t.string :client, limit: 100, null: false
      t.datetime :date, precision: nil
      t.string :payment_method, limit: 20, null: false
      t.string :ref, limit: 50, null: false
      t.string :classification, limit: 4
      t.decimal :amount_paid, precision: 10, scale: 2, null: false
      t.decimal :commissionable_amount, precision: 10, scale: 2, null: false
      t.decimal :commission_percentage, precision: 10, scale: 3, null: false
      t.decimal :commission, precision: 10, scale: 2, null: false
      t.decimal :po_amount, precision: 10, scale: 2
      t.decimal :previously_paid, precision: 10, scale: 2, null: false
      t.boolean :is_adjustment, null: false
      t.datetime :updated, precision: nil, null: false
      t.string :notes
    end
  end
end
