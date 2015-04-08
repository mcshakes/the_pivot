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
    expect(page).to have_content("Update Your Address")
  end



end
