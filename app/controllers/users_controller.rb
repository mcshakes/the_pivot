class UsersController < ApplicationController
  # before_filter :authorize, :only => [:show]

  def new
    @user = User.new
  end

  def show
    unless signed_in?
      flash[:danger] = "You must sign in to see your account."
      redirect_to root_path
    end
    # @orders = Order.where(user_id: current_user.id)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in
    else
      redirect_to :back
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :display_name, :email, :password, :password_confirmation)
  end

  def sign_in
    session[:user_id] = @user.id
    redirect_to @user
  end

end
