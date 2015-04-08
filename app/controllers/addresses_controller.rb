class AddressesController < ApplicationController

  def index
    @addresses = Address.all
  end

  def create

  end

  def update

  end

  def edit
    addresses = Address.find_by(current_user.addresses)
  end

end
