class CreateCoreAccounts < ActiveRecord::Migration[7.0]
  def change
    create_table :core_accounts do |t|
      t.string :company_name, limit: 100
      t.string :first_name, limit: 100
      t.string :last_name, limit: 100
      t.string :match_key, limit: 100
      t.string :address
      t.string :address2
      t.string :city, limit: 50
      t.string :state, limit: 5
      t.string :country, limit: 2
      t.string :zip, limit: 10
      t.string :phone, limit: 14
      t.string :toll_free_number, limit: 14
      t.string :fax, limit: 14
      t.datetime :created
      t.integer :rep_id
      t.integer :primary_users
    end
  end
end
