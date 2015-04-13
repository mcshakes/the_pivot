class RenameFavoriteItemsToFavorites < ActiveRecord::Migration
  def change
    rename_table :favorite_items, :favorites
  end
end
