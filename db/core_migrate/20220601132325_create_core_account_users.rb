class CreateCoreAccountUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :account_users do |t|
      t.integer :account_id
      t.integer :user_id
      t.boolean :approve_orders, default: false
      t.boolean :make_payments, default: false
      t.boolean :receive_shipments, default: false
      t.boolean :removed, default: false
      t.boolean :administrator, default: false
      t.timestamps
    end
  end
end
