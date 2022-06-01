class AddAccountToUsers < ActiveRecord::Migration[7.0]
  def change
    change_table :users do |t| 
      t.references :account, type: :bigint
    end
  end
end
