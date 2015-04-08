class AddressesController < ApplicationController

  def create

  end

  def update

  end

  def edit
    addresses = Addresses.find_by(current_user.addresses)
  end

end
