class CreateHotPosts < ActiveRecord::Migration[6.1]
  def change
    create_table :hot_posts do |t|

      t.integer :end_user_id, null: false
      t.integer :genre_id, null: false
      t.integer :hot_spring_id
      t.string :title, null: false
      t.text :body, null: false
      t.timestamps
    end
  end
end

