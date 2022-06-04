class CreatePersonas < ActiveRecord::Migration[7.0]
  def change
    create_table :personas do |t|
        t.string :name
        t.text :selects
        t.text :image_path
        t.timestamps
    end
  end
end
