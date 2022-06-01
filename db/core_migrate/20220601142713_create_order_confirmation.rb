class CreateOrderConfirmation < ActiveRecord::Migration[7.0]
  def change
    create_table :order_confirmations do |t|
      t.integer :order_id
      t.integer :user_id, null: false
      t.string :name, limit: 100, null: false
      t.datetime :created, precision: nil
      t.string :ip, limit: 25
      t.string :useragent
      t.datetime :timestamp, precision: nil
      t.string :file, limit: 100
      t.string :job_title, limit: 100
    end
  end
end
