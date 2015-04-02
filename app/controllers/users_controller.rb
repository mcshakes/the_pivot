class UsersController < ApplicationController
  before_filter :authorize

  def new
    @user = User.new
  end

  def show
    @orders = Order.where(user_id: current_user.id)
  end

  
  private

  def authorize
    if current_user.nil?
      redirect_to login_path, alert: "You must sign in"
    end
  end
end
