class CreateCountStatusLog < ActiveRecord::Migration[7.0]
  def change
    create_table :count_status_logs do |t|
      t.integer :count_id
      t.integer :user_id
      t.integer :status
      t.integer :results
      t.string :ref_no, limit: 50
      t.datetime :created
      t.text :notes
      t.text :selects
      t.text :attachments
    end
  end
end
