class CartItemsController < ApplicationController

  def create
    # binding.pry
    item = Item.find(params[:item_id])
    # item = Item.find(params[:id])
    cart_data
    @cart.add_item(item)
    flash[:notice] = "You have #{pluralize(@cart.item_quantity(item), item.name)} in your cart."
    # redirect_to cart_path
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
