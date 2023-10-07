class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|

      t.string :title, null: false
      t.text :boby, null: false
      t.timestamps
    end
  end
end
