class CreateSystemNotices < ActiveRecord::Migration[7.0]
  def change
    create_table :system_notices do |t|

      t.timestamps
    end
  end
end
