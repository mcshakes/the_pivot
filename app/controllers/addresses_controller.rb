class AddressesController < ApplicationController

  def index
    @addresses = Address.all
  end

  def create
    # binding.pry
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

  end

  def update

  end

  def edit
    addresses = Address.find_by(current_user.addresses)
  end

  private

  def strong_params
    params.require(:address).permit(:street, :city, :state, :country, :type)
  end

end
