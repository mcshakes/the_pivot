require "rails_helper"

RSpec.feature "authenticated user tries to create a store", type: :feature do
  it "can create a store when all relevant information is filled in" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    click_link_or_button("Create a Store")
    fill_in("store[name]", with: "Sweet Lovin' BBQ")
    fill_in("store[description]", with: "Best BBQ Evah")
    fill_in("store[credit_cart]", with: "4242 4242 4242 4242")
    click_link_or_button("Make Me a Store")
    expect(page).to have_content("Add An Item")
  end

  xit "cannot create a store without a name" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    new_vendor_path
    fill_in("store[name]", with: "  ")
    fill_in("store[credit_cart]", with: "4242 4242 4242 4242")
    expect(current_path).to eq(new_vendor_path)
  end

  xit "cannot create a store without a description" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    new_vendor_path
    fill_in("store[name]", with: "Sweet Lovin' BBQ")
    fill_in("store[description]", with: "")
    fill_in("store[credit_cart]", with: "4242 4242 4242 4242")
    click_link_or_button("Make Me a Store")
    expect(current_path).to eq(new_vendor_path)
  end

  xit "cannot create a store with incorrect credit card info" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    new_vendor_path
    fill_in("store[name]", with: "Sweet Lovin' BBQ")
    fill_in("store[description]", with: "Best BBQ Evah")
    fill_in("store[credit_cart]", with: "4242 4242")
    click_link_or_button("Make Me a Store")
    expect(current_path).to eq(new_vendor_path)
  end


  xit "cannot create two stores with the same name" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    new_vendor_path
    fill_in("store[name]", with: "Sweet Lovin' BBQ")
    fill_in("store[description]", with: "Best BBQ Evah")
    fill_in("store[credit_cart]", with: "4242 4242 4242 4242")
    expect(current_path).to eq(new_vendor_path)
  end

  xit "cannot create two stores with the same slug" do
    user = create(:user)
    vendor = create(:vendor1)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_vendor_path
    fill_in("store[name]", with: "Ansel Adam-s")
    fill_in("store[description]", with: "Best BBQ Evah")
    fill_in("store[credit_cart]", with: "4242 4242 4242 4242")
    expect(current_path).to eq(new_vendor_path)
  end
end
