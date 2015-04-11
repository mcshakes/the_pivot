class Vendors::ItemsController < ApplicationController

  def index
    @vendor = Vendor.find_by(slug: params[:slug])
    @heading = "Welcome to #{@vendor.name}'s Photo Gallery"
    @items = @vendor.items
  end

  def show
    @vendor = Vendor.find_by(slug: params[:slug])
    @item = @vendor.items.find(params[:id])
    render :layout => !request.xhr?
  end

  def new
    if current_user.role == "store_admin"
      @item = Item.new
    else
      flash[:danger] = "You are not authorized to access this page"
      redirect_to :back
    end
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      update_categories
      flash[:success] = "New item has been created!"
      redirect_to vendor_item_path(@item)
    else
      flash[:error] = "Attributes missing"
      redirect_to new_vendor_item_path
    end
  end

  # def edit
  #   @item = Item.find_by(parameterized_name: params[:item_name])
  #   authorize! :edit, @item
  # end

  # def update
  #   @item = Item.find_by(parameterized_name: params[:item_name])
  #   if @item.update(item_params)
  #     update_categories
  #     flash[:success] = "Item has been successfully updated!"
  #     redirect_to menu_item_path(@item)
  #   else
  #     flash[:error] = "Attributes missing."
  #     redirect_to :back
  #   end
  # end

  private

  def update_categories
    ItemCategory.destroy_all(item_id: @item.id)
    params[:category_ids].each do |category|
      category_id = category.to_i
      ItemCategory.create(item_id: @item.id, category_id: category_id)
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_ids, :status)
  end
end
