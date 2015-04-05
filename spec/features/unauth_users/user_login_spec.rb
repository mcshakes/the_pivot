require "rails_helper"
require "support/factory_girl"

RSpec.feature "Unauthenticated user", type: :feature do
  it "cannot view account page until logged in" do
    visit account_path
    expect(page).to have_content("You must sign in")
    expect(page).to have_content("Sign In")

    user_sign_in
    expect(page).to have_content("Sign in successful")

    visit account_path
    expect(page).not_to have_content("You must sign in")
  end

  it "cannot user_sign_in with incorrect email or password" do
    user = create(:user)
    visit login_path

    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: "incorrect"
    within("form") { click_link_or_button "Sign in" }

    expect(page).to have_content("Invalid email or password, try again")
    expect(page).to have_content("Sign In")

  end

  it "can logout if already logged in" do
    visit login_path
    user_sign_in
    click_link_or_button "Sign Out"

    expect(page).to have_content("Signed out")
    expect(page).to have_content("Sign In")
  end

  private

  def user_sign_in
    visit login_path
    user = create(:user)
    fill_in "session[email]", with: user.email
    fill_in "session[password]", with: user.password
    within("form") { click_link_or_button "Sign in" }
  end
end
