class VendorsController < ApplicationController

  def index
    @vendors = Vendor.all
  end

  def show
  end

  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      redirect_to vendor_path(slug: @vendor.slug)
    end
  end

  private
  def vendor_params
    params.require(:vendor).permit(:name, :description, :credit_card)
  end

end
