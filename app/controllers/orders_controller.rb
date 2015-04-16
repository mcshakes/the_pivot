class OrdersController < ApplicationController
  def create
    if current_user
      create_order
      reset_cart
      flash[:success] = "Your order has been placed."
      redirect_to account_path
    else
      flash[:error] = "You must sign in if you want to place an order."
      redirect_to login_path
    end
  end

  def show
    @order = Order.find(params[:id])
    authorize! :show, @order
  end

  def complete
    @order = Order.find(params[:id])
    @order.status = "completed"
    @order.save
    flash[:notice] = "Order marked as completed."
    redirect_to :back
  end

  private

  def reset_cart
    session[:cart] = Hash.new
  end

  def create_order
    order = Order.create(user_id: current_user.id)
    cart_data.each do |item, qty|
      order.item_orders.create(item_id: item, quantity: qty)
    end
  end
end
