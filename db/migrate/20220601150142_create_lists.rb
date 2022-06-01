class CreateLists < ActiveRecord::Migration[7.0]
  def change
    create_table :lists do |t|
      t.references :user, type: :bigint
      t.references :data_source, type: :bigint
      t.string :name
      t.text :selects
      t.timestamps
    end
  end
end
