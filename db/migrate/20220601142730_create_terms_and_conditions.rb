class CreateTermsAndConditions < ActiveRecord::Migration[7.0]
  def change
    create_table :terms_and_conditions do |t|
      t.datetime :active_date, precision: nil, null: false
      t.datetime :inactive_date, precision: nil
      t.string :url, null: false
      t.string :description, limit: 100, null: false
      t.string :classification, limit: 4, null: false
      t.string :display, limit: 100, null: false
    end
  end
end
