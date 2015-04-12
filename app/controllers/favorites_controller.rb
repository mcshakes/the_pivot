class FavoritesController < ApplicationController

  def index
    @heading = current_user.first_name + "'s Favorites"
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
