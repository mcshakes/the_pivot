class CreateFavoriteItems < ActiveRecord::Migration
  def change
    create_table :favorite_items do |t|
      t.integer :user_id
      t.integer :item_id

      t.timestamps null: false
    end
  end
end
