class CreateOrderStatusLog < ActiveRecord::Migration[7.0]
  def change
    create_table :order_status_logs do |t|
      t.integer :order_id
      t.integer :user_id
      t.datetime :date
      t.integer :status
      t.text :notes
    end
  end
end
