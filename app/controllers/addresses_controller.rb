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

  def update
    @address = Address.find(params[:id])
    if @address.update(strong_params)
       flash[:success] = "Address has been successfully updated!"
       redirect_to addresses_path
     else
      #  flash[:error] = "Attributes missing."
      #  redirect_to :back
     end
  end

  private

  def strong_params
    params.require(:address).permit(:street, :city, :state, :country, :type)
  end

end
