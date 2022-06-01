class CreateVendors < ActiveRecord::Migration[7.0]
  def change
    create_table :vendors do |t|
      t.integer :company_id, null: false
      t.string :contact_name, limit: 100, null: false
      t.string :contact_email, limit: 100, null: false
      t.datetime :created, precision: nil, null: false
      t.string :name, limit: 100
      t.string :match_key, limit: 100
      t.string :address
      t.string :address2
      t.string :city, limit: 50
      t.string :state, limit: 2
      t.string :country, limit: 2, default: 'US', null: false
      t.string :zip, limit: 10
      t.string :phone, limit: 14
      t.string :toll_free_number, limit: 14
      t.string :cust_service_number, limit: 14
      t.string :fax, limit: 14
      t.timestamps
    end
  end
end
