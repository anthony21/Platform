class CreatePayPeriods < ActiveRecord::Migration[7.0]
  def change
    create_table :pay_periods do |t|
      t.datetime :start_date, precision: nil, null: false
      t.datetime :end_date, precision: nil, null: false
      t.datetime :run_date, precision: nil, null: false
      t.datetime :last_processed, precision: nil
      t.datetime :payment_date, precision: nil
      t.string :file_name, limit: 100
      t.string :description, limit: 100
      t.text :notes
    end
  end
end
