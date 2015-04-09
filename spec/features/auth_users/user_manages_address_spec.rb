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

  it "sees a button to add an address" do
    user_visits_account
    expect(page).to have_link("Update Your Address")
    click_link_or_button("Update Your Address")
    expect(current_path).to eq(addresses_path)
    expect(page).to have_content("Your Address Info")
  end

  it "allows you to visit a new address page" do
    user_visits_account
    click_link_or_button("Update Your Address")
    click_link_or_button("Add a New Address")
    expect(current_path).to eq(new_address_path)
    expect(page).to have_content("Add a New Address")
  end

  it "creates a new address" do
    user_visits_account
    click_link_or_button("Update Your Address")
    click_link_or_button("Add a New Address")
    expect(current_path).to eq(new_address_path)

    fill_in("address[street]", with: "123 doc drive")
    fill_in("address[city]", with: "durango")
    fill_in("address[state]", with: "Colorado")
    fill_in("address[country]", with: "Mexico")
    click_link_or_button("Add Address")
    save_and_open_page
    expect(current_path).to eq(addresses_path)

  end


end
