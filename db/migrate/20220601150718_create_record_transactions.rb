class CreateRecordTransactions < ActiveRecord::Migration[7.0]
  def change
    create_table :record_transactions do |t|
      t.belongs_to :account
      t.integer :record_count
      t.timestamps
    end
  end
end
