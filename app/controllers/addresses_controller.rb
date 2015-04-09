class AddressesController < ApplicationController

  def index
    @addresses = current_user.addresses
  end

  def new
    @address = Address.new
  end

  def create
    user_address = current_user.addresses.new(strong_params)
    if user_address.save
      flash[:notice] = "Address Successfully Added"
      redirect_to addresses_path
    else
      flash[:error] = "Attributes missing."
      redirect_to :back
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(strong_params)
       flash[:success] = "Address has been successfully updated!"
       redirect_to addresses_path
     else
       flash[:error] = "Attributes missing."
       redirect_to :back
     end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    flash[:notice] = "The Address has been removed from your account."
  end

  def destroy
    if Address.destroy(params[:id])
      flash[:notice] = "Address Deleted"
      redirect_to addresses_path
    else
      flash[:notice] = "Something Happened..."
    end
  end

  private

  def strong_params
    params.require(:address).permit(:street, :city, :state, :country, :type)
  end

end
