class AddressesController < ApplicationController

  def index
    @addresses = current_user.addresses
  end

  def new
    @address = Address.new
  end

  def create
    # @address = Address.new(strong_params)
    # user_address = current_user.addresses << @address
    user_address = current_user.addresses.new(strong_params)
    if user_address.save
      flash[:notice] = "Address Successfully Added"
      redirect_to addresses_path
    else
      flash[:notice] = "Try Again"
      render :new
    end
  end

  def show
    # @addresses = @user.addresses
  end

  def update
    # address = Address.find_by(params[:user_id])
    @address = Address.find(params[:id])
  end

  def edit
  end

  private

  def strong_params
    params.require(:address).permit(:street, :city, :state, :country, :type)
  end

end
