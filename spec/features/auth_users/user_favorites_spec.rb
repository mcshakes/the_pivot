require "rails_helper"

RSpec.feature "authenticated user adds favorites", type: :feature do
  attr_reader :vendor, :item

  def create_vendor_item_user
    @vendor = create(:vendor, name: "Sports Pics")
    @item = create(:item, :for_sale, name: "Super Sold Photograph", vendor: vendor)
    user = create(:user)
  end

  def visit_vendor_click_item
    visit vendor_items_path(slug: vendor.slug)
    click_link_or_button(item.name)
  end

  it "can see a favorites link on the item modal" do
    create_vendor_item_user
    visit_vendor_click_item
    expect(page).to have_link("Favorite")
  end

  it "can add favorites to the user dashboard" do
    create_vendor_item_user
    visit_vendor_click_item
    click_link_or_button("Favorite")
    visit user_path
    expect(page).to have_link("Super Sold Photograph")
  end


end

