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

  it "accesses account page from the nav bar" do
    user = User.create(first_name: "Bob", last_name: "Bobbyson", email: "bobson@hotmail.com", password: "password")
    user_sign_in(user)
    expect(page).to have_content("Sign in successful")
    click_link_or_button("See My Account")
    expect(current_path).to eq(account_path)
  end

  it "sees a button to edit user info" do
    user_visits_account
    expect(page).to have_link("Edit Personal Info")
    click_link_or_button("Edit Personal Info")
    expect(page).to have_content("Update/Change your Info")
  end

  it "successfully redirects to account page and sees flash notice" do
    user_visits_account
    click_link_or_button("Edit Personal Info")
    within("#update-form") do
      fill_in("user[first_name]", with: "Shelly" )
      click_link_or_button("Update Account")
    end
    expect(current_path).to eq(account_path)
    expect(page).to have_content("Successfully Updated")
  end

  it "successfully updates the data" do
    user_visits_account
    expect(page).to have_link("Edit Personal Info")
    click_link_or_button("Edit Personal Info")
    within("#update-form") do
      fill_in("user[first_name]", with: "Shelly" )
      click_link_or_button("Update Account")
    end
    expect(current_path).to eq(account_path)
  end

end
