require "rails_helper"

RSpec.describe "user manages personal account", type: :feature do

  def user_sign_in(user)
    visit root_path
    within(".navbar-nav") {click_link_or_button "Sign In"}
    within("#signin") do
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password
      within("form") { click_link_or_button "Sign in" }
    end
  end

  def user_visits_account
    user = User.create(first_name: "Bob", last_name: "Bobbyson", email: "bobson@hotmail.com", password: "password")
    user_sign_in(user)
    visit account_path
  end

  def fill_address_fields
    fill_in("address[street]", with: "908 N Obscure Square" )
    fill_in("address[city]", with: "New York" )
    fill_in("address[state]", with: "New Yorkshire" )
    fill_in("address[country]", with: "New Western Territories of Her Majesty" )
  end

  def address_created
    click_link_or_button("Update Your Address")
    click_link_or_button("Add a New Address")
    fill_address_fields
    click_link_or_button("Add Address")
  end

  it "adds a new address" do
    user_visits_account
    click_link_or_button("Update Your Address")
    expect(page).to have_content("Your Address Info")
    click_link_or_button("Add a New Address")
    fill_address_fields
    click_link_or_button("Add Address")
    expect(page).to have_content("Address Successfully Added")
  end

  it "asks for more attributes when missing" do
    user_visits_account
    click_link_or_button("Update Your Address")
    expect(page).to have_content("Your Address Info")
    click_link_or_button("Add a New Address")
    fill_in("address[street]", with: "908 N Obscure Square" )
    fill_in("address[city]", with: "New York" )
    click_link_or_button("Add Address")
    expect(page).to have_content("Attributes missing")
  end

  it "successfully edits address" do
    user_visits_account
    address_created
    click_link_or_button("Edit Existing Address")
    expect(page).to have_content("Update Your Address")
    fill_in("address[street]", with: "910 A new name" )
    fill_in("address[city]", with: "New Berlin" )
    fill_in("address[state]", with: "wiemerhammer" )
    fill_in("address[country]", with: "West Germany" )
    click_link_or_button("Update Address")
    expect(page).to have_content("Address has been successfully updated")
    expect(current_path).to eq(addresses_path)
  end

  it "needs valid data to edit addresses" do
    user_visits_account
    address_created
    click_link_or_button("Edit Existing Address")
    expect(page).to have_content("Update Your Address")
    fill_in("address[street]", with: "910 A new name" )
    fill_in("address[city]", with: "New Berlin" )
    click_link_or_button("Update Address")
    expect(page).to have_content("Attributes missing")
  end

  it "deletes the address and redirects to address index" do
    user_visits_account
    address_created
    expect(page).to have_content("Delete Existing Address")
    click_link_or_button("Delete Existing Address")
    expect(page).to have_content("Address Deleted")
    expect(current_path).to eq(addresses_path)

  end









end
