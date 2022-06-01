class CreateCounts < ActiveRecord::Migration[7.0]
  def change
    create_table :counts do |t|
      t.integer :client
      t.integer :user_id, null: false
      t.integer :processor_id
      t.integer :status, null: false
      t.integer :results
      t.string :name, limit: 100
      t.string :email
      t.string :ref_no, limit: 100
      t.datetime :created, null: false
      t.datetime :updated, null: false
      t.datetime :submitted
      t.datetime :completed
      t.text :selects
      t.text :notes
      t.text :attachments
      t.integer :is_flagged, limit: 1, default: 0
    end
  end
end
