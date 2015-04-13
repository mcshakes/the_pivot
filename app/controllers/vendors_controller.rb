class VendorsController < ApplicationController

  def index
    @vendors = Vendor.with_items
  end

  def new
  end

  def create
    @vendor = Vendor.new(vendor_params)
    current_user.vendors << @vendor

    if @vendor.save
      redirect_to vendor_items_path(slug: @vendor.slug)
    else
      flash[:danger] = "Please enter unique and accurate information."
      render :new
    end
  end

  def edit
  end


  def update
    vendor = Vendor.find_by(id: params[:slug])
      # binding.pry  ## Over here params[slug] 12. Which is the ID of vendor
    if vendor.update(vendor_params)
      # binding.pry  ## Over here the slug is the proper name
      redirect_to vendor_items_path(slug: vendor.slug)
      flash[:notice] = "Account Updated"
    else
      flash[:notice] = "bad"
      render :edit
    end
  end

  private

  def vendor_params
    params.require(:vendor).permit(:name, :description, :credit_card)
  end

end
