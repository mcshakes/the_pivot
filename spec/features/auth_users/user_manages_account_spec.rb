require "rails_helper"

RSpec.describe "user manages personal account", type: :feature do

  # let!(:user) { create(:user)}
  # before(:each) { set_current_user(user)}

  def user_sign_in(user)
    visit root_path
    within(".navbar-nav") {click_link_or_button "Sign In"}
    within("#signin") do
      fill_in "session[email]", with: user.email
      fill_in "session[password]", with: user.password
      within("form") { click_link_or_button "Sign in" }
    end
  end

  it "accesses account page from the nav bar" do
    user = create(:user, first_name: "Bob", last_name: "Bobbyson", email: "bobson@hotmail.com", password: "password")
    user_sign_in(user)
    expect(page).to have_content("Sign in successful")
    click_link_or_button("Account")
    expect(current_path).to eq(account_path)
    expect(page).to have_content("My Account")
  end

  it "sees a button to edit user info" do
    user = create(:user, first_name: "Bob", last_name: "Bobbyson", email: "bobson@hotmail.com", password: "password")
    user_sign_in(user)
    visit account_path
    expect(page).to have_link("Edit Your Info")

    click_link_or_button("Edit Your Info")
    # expect(current_path).to eq(edit_user_path)
    expect(page).to have_content("Update/Change your Info")
  end

  it "changes info and that info is updated" do


  end

  xit "cannot input invalid info for the update data" do


  end

end

# Shipping addresses
# Billing addresses
# Credit cards associated with my account
# Basic account info like name and password, as managed previously in Dinner Dash v1
# Favourites
