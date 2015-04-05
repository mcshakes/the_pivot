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
    create(:user)
    visit login_path
    fill_in "session[email]", with: "richard@example.com"
    fill_in "session[password]", with: "incorrect"
    within("form") { click_link_or_button "Sign in" }
    expect(page).to have_content("Invalid email or password, try again")
    expect(page).to have_content("Sign In")

    # expect(ActionMailer::Base.deliveries.length).to eq(1)
  end

  it "confirms its email address" do
    create(:email_confirmation, token: "unique-token")
    visit email_confirmation_path("unique-token")

    expect(page).to have_content("You confirmed your email! High five!")
    expect_user_to_be_signed_in
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
    create(:user)
    fill_in "session[email]", with: "richard@example.com"
    fill_in "session[password]", with: "hello"
    within("form") { click_link_or_button "Sign in" }
  end
end
