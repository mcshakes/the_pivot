class Vendors::ItemsController < ApplicationController

  def index
    @heading = "Welcome to #{current_vendor.name}'s Photo Gallery"
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

  # def edit
  #   @item = Item.find_by(parameterized_name: params[:item_name])
  #   authorize! :edit, @item
  # end

  def edit
    @item = Item.find(params[:id])
    if @item.update(item_params)
      update_categories
      flash[:success] = "Item has been successfully updated!"
      redirect_to menu_item_path(@item)
    else
      flash[:error] = "Attributes missing."
      redirect_to :back
    end
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
