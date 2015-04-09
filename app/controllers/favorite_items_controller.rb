class FavoriteItemsController < ApplicationController

  def index
    puts "Index - Favorite Items"
    favorites = current_user.favorite_items
    @favorite_items = favorites.map do |favorite|
      Item.find(favorite.item_id)
    end
  end

  def create
    puts "Create - Favorite Items"
    if signed_in?
    require 'pry';binding.pry 
      favorite_item = FavoriteItems.create(user_id: current_user.id, item_id: item.id)
      flash[:success] = "Favorite!"
    else
      flash[:danger] = "You must be logged in the save a favorite!"
    end
  end

end
