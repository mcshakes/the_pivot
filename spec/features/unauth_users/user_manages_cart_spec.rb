require "rails_helper"

RSpec.describe "unauthenticated user managing cart", type: :feature, js: true do

  it "can add a for sale item to cart from one store" do
    vendor = create(:vendor)
    item = create(:item, :for_sale, vendor: vendor)
    visit vendors_path

    click_link_or_button(vendor.name)
    click_link_or_button(item.name)
    click_link_or_button("Buy")
    expect(page).to have_content("#{item.name} was added to your cart.")
  end

  it "cannot add a sold item to the cart" do
    vendor = create(:vendor, name: "Sports Pics")
    item = create(:item, :sold, name: "Super Sold Photograph", vendor: vendor)
    visit vendors_path

    click_link_or_button(vendor.name)
    click_link_or_button(item.name)
    expect(page).not_to have_button("Buy")
  end

  it "can add for sale items to cart from multiple stores" do
    vendor = create(:vendor, name: "Bob's Photo Shop")
    item = create(:item, :for_sale, name: "Beautiful Image", vendor: vendor)
    vendor2 = create(:vendor, name: "Another Photo Store")
    item2 = create(:item, :for_sale, name: "Food Glorious Food", vendor: vendor2)

    visit vendors_path
    click_link_or_button(vendor.name)
    click_link_or_button(item.name)
    click_link_or_button "Buy"

    visit vendors_path
    click_link_or_button(vendor2.name)
    click_link_or_button(item2.name)
    click_link_or_button "Buy"

    visit cart_path
    expect(page).to have_content("Beautiful Image")
    expect(page).to have_content("Food Glorious Food")
    expect(page).to have_content("Total Items: 2")
  end

  it "allows users to remove things from their cart" do
    vendor = create(:vendor, name: "Sports Pics")
    item = create(:item, :for_sale, name: "Super Sold Photograph", vendor: vendor)

    visit vendors_path
    click_link_or_button(vendor.name)

    click_link_or_button(item.name)
    click_link_or_button("Buy")
    visit cart_path
    find("#down_button").click

    expect(page).to have_content("The item has been removed from your cart")
    expect(page).to_not have_content("Super Sold Photograph")
  end

  it "allows users to increase the quantity of an item in their cart" do
    vendor = create(:vendor, name: "Sports Pics")
    item = create(:item, :for_sale, name: "Super Sold Photograph", vendor: vendor)

    visit vendors_path
    click_link_or_button(vendor.name)

    click_link_or_button(item.name)
    click_link_or_button("Buy")
    visit cart_path
    find("#up_button").click
    expect(page).to have_content("Quantity: 2")
    expect(page).to have_content("12.00")
  end

  it "can click checkout button and be routed to the login page" do
    vendor = create(:vendor, name: "Sports Pics")
    item = create(:item, :for_sale, name: "Super Sold Photograph", vendor: vendor)

    visit vendors_path
    click_link_or_button(vendor.name)

    click_link_or_button(item.name)
    click_link_or_button("Buy")
    visit cart_path
    click_link_or_button("Checkout")
    expect(page).to have_content("Sign In")
  end
  #
  # it "views their cart" do
  #   create_item_and_add_to_cart
  #   visit cart_path
  #   expect(page).to have_content("Salted Caramel Peanut Butter Cup")
  # end
  #
  # it "sees the correct quantity for a specific item" do
  #   create_item_and_add_to_cart
  #   2.times { click_link_or_button "Add to Cart" }
  #   visit cart_path
  #   expect(page).to have_content("Quantity: 3")
  # end
  #
  # it "allows users to remove things from their cart" do
  #   create_item_and_add_to_cart
  #   visit cart_path
  #   click_link('', href: '/cart_items/1')
  #   expect(page).to have_content("The item has been removed from your cart")
  #   expect(page).to_not have_content("Salted Caramel")
  # end
  #
  # it "allows users to increase the quantity of an item in their cart" do
  #   create_item_and_add_to_cart
  #   visit cart_path
  #   click_link("", href: "/cart_items?item=salted-caramel-peanut-butter-cup")
  #   expect(page).to have_content("Quantity: 2")
  #   expect(page).to have_content("12.00")
  # end
  #
  # it "allows user to delete all of one item at once" do
  #   create_item_and_add_to_cart
  #   visit cart_path
  #   click_link("", href: "/cart_items?item=salted-caramel-peanut-butter-cup")
  #   click_link_or_button("Remove All")
  #   expect(page).to have_content("Total Items: 0")
  # end
  #
  # it "can sign in and the cart should not change" do
  #   create_item_and_add_to_cart
  #   visit cart_path
  #   expect(page).to have_content("Quantity: 1")
  #   visit account_path
  #   user_sign_in
  #   visit cart_path
  #   expect(page).to have_content("Quantity: 1")
  # end


  # def user_sign_in
  #   fill_in "session[email]", with: "richard@example.com"
  #   fill_in "session[password]", with: "password"
  #   within("form") { click_link_or_button "Sign in" }
  # end
end
