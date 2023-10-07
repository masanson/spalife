class CreateHotSprings < ActiveRecord::Migration[6.1]
  def change
    create_table :hot_springs do |t|

      t.timestamps
    end
  end
end
