require "rails_helper"
require "support/factory_girl"

RSpec.feature "Unauthenticated user", type: :feature do

  def incorrect_registration
    fill_in("user[first_name]", with: "Pip" )
    fill_in("user[last_name]", with: "Pippo" )
    fill_in("user[email]", with: "esxxsa.com" )
  end

  def correct_registration
    fill_in("user[first_name]", with: "Pip" )
    fill_in("user[last_name]", with: "Pippo" )
    fill_in("user[email]", with: "pipmagnet@yahoo.com" )
    fill_in("user[password]", with: "password" )
    fill_in("user[password_confirmation]", with: "password" )

  end

  def get_registration_form
    visit root_path
    click_link_or_button("Sign Up")
  end

  it "sees the sign in button on the homepage" do
    visit root_path
    within(".navbar-header") do
      expect(page).to have_content("Sign Up")
    end
  end

  it "sees a user registration form" do
    get_registration_form
    expect(current_path).to eq(signup_path)
    within(".register-page") do
      expect(page).to have_content("First name")
      expect(page).to have_content("Last name")
    end
  end

  it "gets error messages if filling in the form with invalid inputs" do
    get_registration_form
    incorrect_registration
    click_link_or_button("Create Account")

    within("#error_explanation") do
      expect(page).to have_content("The form contains 2 errors")
      expect(page).to have_content("Email is invalid")
      expect(page).to have_content("Password can't be blank")
    end
  end

  it "is taken to the user home page upon correct registration" do
    get_registration_form
    correct_registration
    click_link_or_button("Create Account")
    # save_and_open_page
    # within(".user_view") do
      expect(page).to have_content("Welcome Pip")
    # end
  end

end
