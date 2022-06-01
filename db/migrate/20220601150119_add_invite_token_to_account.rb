class AddInviteTokenToAccount < ActiveRecord::Migration[7.0]
  def change
    change_table :accounts do |t| 
      t.string :invite_token
    end
  end
end
