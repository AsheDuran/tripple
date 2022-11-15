class CreateSpots < ActiveRecord::Migration[6.1]
  def change
    create_table :spots do |t|

      t.integer :end_user_id, null: false
      t.integer :prefecture_id, null: false
      t.integer :genre_id, null: false
      t.string :name, null: false
      t.string :address, null: false
      t.text :explanation, null: false
      t.boolean :is_published_flag, null: false
      #t.integer :star, null: false

      t.timestamps
    end
  end
end
