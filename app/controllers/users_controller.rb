class UsersController < ApplicationController
  # before_filter :authorize, :only => [:show]

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
    @orders = Order.where(user_id: current_user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to user_path(@user.id)
    else
      render :new
    end
  end

  private

  # def authorize
  #   if current_user.nil?
  #     redirect_to signup_path, alert: "You must sign in"
  #   end
  # end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :display_name, :email, :password, :password_confirmation)
  end

end
