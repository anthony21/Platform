class CreateCoreUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :core_users do |t|
      t.integer :role_id
      t.string :email
      t.string :password, limit: 32
      t.string :first_name, limit: 100
      t.string :last_name, limit: 100
      t.string :phone, limit: 14
      t.string :phone_extension, limit: 10
      t.string :cell_phone, limit: 14
      t.column :recover, 'char(12)'
      t.datetime :created, null: false
      t.datetime :last_login
    end
  end
end
