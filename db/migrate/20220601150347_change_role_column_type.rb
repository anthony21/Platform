class ChangeRoleColumnType < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :role
    add_column :users, :role, :integer
  end
end
