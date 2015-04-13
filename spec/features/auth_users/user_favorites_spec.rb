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

  def visit_vendor_click_item_favorite_link 
    visit vendor_items_path(slug: vendor.slug)
    click_link_or_button(item.name)
    click_link("Favorite")
  end

  it "can see a favorites link on the item modal" do
    create_vendor_item_user
    visit_vendor_click_item_favorite_link 
    visit vendor_items_path(slug: item.vendor.slug)
    click_link_or_button(item.name)

    expect(page).to have_link("Favorite")
  end

  it "can add favorites to the user favorites page" do
    create_vendor_item_user
    visit_vendor_click_item_favorite_link 
    visit vendor_items_path(slug: vendor.slug)
    click_on('My Account')
    click_on('See Favorites')
    expect(page).to have_content("Super Sold Photograph")
  end

  it "can add favorite image only once" do
    create_vendor_item_user
    visit_vendor_click_item_favorite_link 
    click_link_or_button(item.name)
    click_link("Favorite")
    visit favorites_path

    expect(page).to have_content("Super Sold Photograph", count: 1)
  end

  it "can not see the favorite button when item favorited" do
    create_vendor_item_user
    visit_vendor_click_item_favorite_link 
    visit favorites_path
    click_link_or_button(item.name)
    within('#modal') do
      expect(page).not_to have_content("Favorite")
    end
  end

  xit "can see favorite button is yellow if item is favorited" do
    visit favorites_path
    click_link_or_button(item.name)

    expect

  end

end

