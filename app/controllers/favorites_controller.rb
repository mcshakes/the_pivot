class FavoritesController < ApplicationController

  def index
    # puts "Index - Favorite Items"

    @heading = "My Favorites"
    @items = current_user.favorite_items

    render "vendors/items/index"
  end

  def create
    item = Item.find(params[:item_id])

    if !current_user.favorite_items.include?(item)
      current_user.favorite_items << item
    end

    head :ok
  end

end
