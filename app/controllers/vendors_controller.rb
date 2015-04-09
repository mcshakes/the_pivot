class VendorsController < ApplicationController

  def index
    @vendors = Vendor.find(Item.pluck(:vendor_id).uniq.compact)
  end

  def create
    @vendor = Vendor.new(vendor_params)
    if @vendor.save
      current_user.vendors << @vendor
      redirect_to vendor_items_path(slug: @vendor.slug)
    else
      flash[:danger] = "Please enter unique and accurate information."
      render :new
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :credit_card)
  end

end
