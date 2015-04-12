require "rails_helper"

RSpec.feature "authenticated user adds favorites", type: :feature do
  attr_reader :vendor, :item

  before do
      user = create(:user)
      visit '/'
      click_on('Sign in')
      click_on('Sign in')
      fill_in("session_email", with: user.email)
      fill_in("session_password", with: user.password)
      click_button "Sign in"
  end

  def create_vendor_item_user
    @vendor = create(:vendor, name: "Sports Pics")
    @item = create(:item, :for_sale, name: "Super Sold Photograph", vendor: vendor)
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

  xit "can add favorites to the user favorites page" do
    create_vendor_item_user
    visit_vendor_click_item
    click_link("Favorite")
    visit vendor_items_path(slug: vendor.slug)
    click_on('My Account')
    click_on('See Favorites')
    expect(page).to have_content("Super Sold Photograph")
  end
end
