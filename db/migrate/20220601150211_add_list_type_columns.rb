class AddListTypeColumns < ActiveRecord::Migration[7.0]
  def change
    add_column :lists, :list_type, :string
  end
end
