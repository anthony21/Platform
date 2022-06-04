class CreateApiRequest < ActiveRecord::Migration[7.0]
  def change
    create_table :api_requests do |t|
      t.string :request_type
      t.string :body
      t.integer :result_count, default: 0
      t.datetime :requested_at
      t.references :account, type: :bigint
      t.timestamps
    end
  end
end
