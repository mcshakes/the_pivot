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
    flash[:notice] = "#{item.name} is now a favorite!"

    redirect_to vendor_items_path(slug: item.vendor.slug)
    end

    # head :ok
  end

end
