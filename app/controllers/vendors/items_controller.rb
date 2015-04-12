class Vendors::ItemsController < ApplicationController

  def index
    @heading = "Welcome to #{current_vendor.name}'s Photo Gallery"
    @description = "\n#{current_vendor.description}"
    @items = current_vendor.items
  end

  def show
    @item = current_vendor.items.find(params[:id])
    render :layout => !request.xhr?
  end

  def new
    if current_user.store_admin?(current_vendor)
      @item = Item.new
    else
      flash[:danger] = "You are not authorized to access this page"
      redirect_to :back
    end
  end

  def create
    current_vendor = Vendor.find(params[:item][:vendor_id])
    @item = Item.new(item_params)
    if @item.save
      current_vendor.items << @item
      update_categories
      flash[:success] = "Your photograph has been added!"
      redirect_to vendor_item_path(slug: current_vendor.slug, id: @item.id)
    else
      flash[:error] = "Attributes missing"
      redirect_to :back
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:item][:item_id])
    @current_vendor = @item.vendor
    if @item.update(item_params)
      update_categories
      flash[:success] = "Item has been successfully updated!"
      redirect_to vendor_items_path(slug: @current_vendor.slug)
    else
      flash[:error] = "Attributes missing."
      redirect_to :back
    end
  end

  def destroy
    @item = Item.find(params[:id])
    Item.destroy(@item)
    redirect_to :back
  end

  private

  def update_categories
    if @item.categories.count > 0
      ItemCategory.destroy_all(item_id: @item.id)
      params[:category_ids].each do |category|
        category_id = category.to_i
        ItemCategory.create(item_id: @item.id, category_id: category_id)
      end
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :price, :image, :category_ids, :status)
  end
end
