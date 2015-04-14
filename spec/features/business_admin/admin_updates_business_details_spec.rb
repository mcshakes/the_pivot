require "rails_helper"

RSpec.describe "admin updates business details", type: :feature do

  it "sees business info when clicking on individual store" do
    create_admin_user_and_vendor
    visit vendor_items_path(slug: @vendor.slug)
    expect(page).to have_content("Welcome to #{@vendor.name}'s Photo Gallery")
    expect(page).to have_content("#{@vendor.description}")
  end

  xit "won't allow admin of other stores to see the page" do
    admin1 = create(:admin)
    vendor1 = create(:vendor)
    admin1.vendors << vendor1
    other_admin = User.create(first_name: "Hey", last_name: "There", email: "admin2@example.com",
                              password: "admin", role: "store_admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_admin)
    visit vendor_items_path(slug: vendor1.slug)
    # save_and_open_page
    expect(page).to have_content("You are not authorized to access this page")
  end

  it "can update the business details" do
    create_admin_user_and_vendor
    visit vendor_items_path(slug: @vendor.slug)
    click_link_or_button("Edit Business Info")
    expect(current_path).to eq(edit_vendor_path(slug: @vendor.slug))
    fill_in("vendor[name]", with: "New Store")
    fill_in("vendor[description]", with: "New Detailed Descriptions. Mindblowing Sales")
    click_link_or_button("Update My Store")
    expect(page).to have_content("New Store")
    expect(page).to have_content("New Detailed Descriptions. Mindblowing Sales")
  end

  it "gets a flash message when updated" do
    create_admin_user_and_vendor
    visit vendor_items_path(slug: @vendor.slug)
    click_link_or_button("Edit Business Info")
    expect(current_path).to eq(edit_vendor_path(slug: @vendor.slug))
    fill_in("vendor[name]", with: "Newer Store")
    click_link_or_button("Update My Store")
    expect(page).to have_content("Account Updated")
  end

  xit "gets error message when given invalid info" do
    # Gets "First argument in form cannot contain nil or be empty" if empty field

  end


  private

  def create_admin_user_and_vendor
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @vendor = create(:vendor)
    @admin.vendors << @vendor
  end

end
