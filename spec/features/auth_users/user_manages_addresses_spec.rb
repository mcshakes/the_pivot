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

  it "adds a new address" do
    user_visits_account
    click_link_or_button("Update Your Address")
    expect(page).to have_content("Your Address Info")
    click_link_or_button("Add a New Address")
    fill_in("address[street]", with: "908 N Obscure Square" )
    fill_in("address[city]", with: "New York" )
    fill_in("address[state]", with: "New Yorkshire" )
    fill_in("address[country]", with: "New Western Territories of Her Majesty" )
    click_link_or_button("Add Address")

    expect(page).to have_content("Address Successfully Added")

  end





end
