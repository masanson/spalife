class CreateHotSprings < ActiveRecord::Migration[6.1]
  def change
    create_table :hot_springs do |t|

      t.integer :prefecture_id, null: false
      t.string :name, null: false
      t.text :introductiion, null: false
      t.string :postal_code, null: false
      t.string :address, null: false
      t.string :telephone_number, null: false
      t.string :access, null: false
      t.timestamps
    end
  end
end
