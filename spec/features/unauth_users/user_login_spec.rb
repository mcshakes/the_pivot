require "rails_helper"
require "support/factory_girl"

RSpec.feature "Unauthenticated user", type: :feature do
  it "cannot view account page until logged in" do
    visit account_path
    within ("div.danger") do
      expect(page).to have_content("You must sign in")
    end
    expect(page).to have_content("Sign In")
    user_sign_in
    within ("div.alert-info") do
      expect(page).to have_content("Sign in successful")
    end
    expect(page).to have_content("Account")
  end

  xit "cannot user_sign_in with incorrect email or password" do
    create(:user)
    visit login_path
    fill_in "session[email]", with: "richard@example.com"
    fill_in "session[password]", with: "incorrect"
    within("form") { click_link_or_button "Sign in" }
    within ("div.alert-danger") do
      expect(page).to have_content("Invalid")
    end
    expect(page).to have_content("Sign in")
  end

  xit "can logout if already logged in" do
    visit login_path
    user_sign_in
    click_link_or_button "Sign out"
    within ("div.alert-info") do
      expect(page).to have_content("Signed out")
    end
    within (".navbar") do
      expect(page).to have_content("Sign in")
    end
  end

  private

  def user_sign_in
    visit login_path
    create(:user)
    fill_in "session[email]", with: "richard@example.com"
    fill_in "session[password]", with: "hello"
    within("form") { click_link_or_button "Sign in" }
  end
end
