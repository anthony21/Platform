class AddApiTokens < ActiveRecord::Migration[7.0]
  def change
    change_table :accounts do |t| 
      t.string :api_token
    end
  end
end
