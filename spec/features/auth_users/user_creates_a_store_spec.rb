require "rails_helper"

RSpec.feature "authenticated user tries to create a vendor", type: :feature do
  it "can create a vendor when all relevant information is filled in" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    click_link_or_button("Create a Store")
    fill_in("vendor[name]", with: "Sweet Lovin' BBQ")
    fill_in("vendor[description]", with: "Best BBQ Evah")
    fill_in("vendor[credit_card]", with: "4242 4242 4242 4242")
    click_link_or_button("Create My Store")
    # expect(current_path).to eq()
    # expect(page).to have_content("Sweet Lovin' BBQ")
    expect(page).to have_content("Welcome to Sweet Lovin' BBQ")
  end

  it "cannot create a vendor without a name" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_vendor_path
    fill_in("vendor[name]", with: "  ")
    fill_in("vendor[credit_card]", with: "4242 4242 4242 4242")
    click_link_or_button("Create My Store")
    expect(page).to have_content("Please enter unique and accurate information.")
  end

  it "cannot create a vendor without a description" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_vendor_path
    fill_in("vendor[name]", with: "Sweet Lovin' BBQ")
    fill_in("vendor[description]", with: "")
    fill_in("vendor[credit_card]", with: "4242 4242 4242 4242")
    click_link_or_button("Create My Store")
    expect(page).to have_content("Please enter unique and accurate information.")
  end

  it "cannot create a vendor with incorrect credit card info" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_vendor_path
    fill_in("vendor[name]", with: "Sweet Lovin' BBQ")
    fill_in("vendor[description]", with: "Best BBQ Evah")
    fill_in("vendor[credit_card]", with: "4242 4242")
    click_link_or_button("Create My Store")
    expect(page).to have_content("Please enter unique and accurate information.")
  end

  it "cannot create two stores with the same name" do
    user = create(:user)
    vendor = create(:vendor, user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_vendor_path
    fill_in("vendor[name]", with: "Ansel Adams")
    fill_in("vendor[description]", with: "Best BBQ Evah")
    fill_in("vendor[credit_card]", with: "4242 4242 4242 4242")
    click_link_or_button("Create My Store")
    expect(page).to have_content("Please enter unique and accurate information.")
  end

  it "cannot create two stores with the same slug" do
    user = create(:user)
    vendor = Vendor.create(name: "Ansel Adam's", description: "black and white", credit_card: "4242 4242 4242 4242", user_id: user.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_vendor_path
    fill_in("vendor[name]", with: "Ansel Adam-s")
    fill_in("vendor[description]", with: "Best BBQ Evah")
    fill_in("vendor[credit_card]", with: "4242 4242 4242 4242")
    click_link_or_button("Create My Store")
    expect(page).to have_content("Please enter unique and accurate information.")
  end
end
