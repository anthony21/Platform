class AddFeaturesToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :features, :text
  end
end
