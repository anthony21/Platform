class AddCoreIdToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :core_user_id, :integer, index: true
  end
end
