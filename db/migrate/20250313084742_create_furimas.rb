class CreateFurimas < ActiveRecord::Migration[7.1]
  def change
    create_table :furimas do |t|
      t.string :name
      t.string :text
      t.text :image
      t.timestamps
    end
  end
end
