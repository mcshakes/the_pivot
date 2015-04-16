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
    vendor = create(:vendor)
    item = create(:item, :for_sale, vendor: vendor)

    visit vendors_path
    click_link_or_button(vendor.name)

    click_link_or_button(item.name)
    click_link_or_button("Buy")
    visit cart_path
    find("#down_button").click

    expect(page).to have_content("The item has been removed from your cart.")
    expect(page).to_not have_content(item.name)
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

  it "can remove all of an item in one click" do
    vendor = create(:vendor, name: "Sports Pics")
    item = create(:item, :for_sale, name: "Super Sold Photograph", vendor: vendor)

    visit vendors_path
    click_link_or_button(vendor.name)

    click_link_or_button(item.name)
    click_link_or_button("Buy")
    visit cart_path
    find("#up_button").click
    expect(page).to have_content("Quantity: 2")
    click_link_or_button("Remove All")
    expect(page).to have_content("The item has been entirely removed from your cart.")
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
end
