class FavoriteItemsController < ApplicationController

  def index
    # puts "Index - Favorite Items"

    @heading = "My Favorites"
    @items = current_user.favorite_items

    render "vendors/items/index"
    # favorites = current_user.favorite_items
    # @favorite_items = favorites.map do |favorite|
    #   Item.find(favorite.item_id)
  end

  def create
    item = Item.find(params[:item_id])
    current_user.favorite_items << item
    render nothing: true
  end

end
