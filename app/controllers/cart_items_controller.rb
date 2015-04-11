class CartItemsController < ApplicationController

  def create
    item = Item.find(params[:item_id])
    cart_data
    @cart.add_item(item)
    flash[:notice] = "#{item.name} was added to your cart."
    redirect_to :back
  end

  def show

  end

  def index
    @cart
  end

  def update
    item = Item.find(params[:id])
    @cart.remove_item(item)
    cart_data
    flash[:notice] = "The item has been removed from your cart."
    redirect_to cart_path
  end

  def destroy
    item = Item.find(params[:id])
    @cart.remove_all_of_item(item)
    flash[:notice] = "The item has been entirely removed from your cart."
    redirect_to cart_path
  end
end
