require "rails_helper"

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
    within ('.navbar') do
      click_link_or_button "Sign In"
    end
    within ('#sign-in-modal') do
      click_link_or_button "Sign In"
    end
  end

  it "sees the sign in button on the homepage" do
    visit root_path
    expect(page).to have_content("Sign In")
  end

  it "sees a user registration form" do
    get_registration_form

    expect(page).to have_content("First name")
    expect(page).to have_content("Last name")
  end

  xit "gets error messages if form is filled with invalid inputs" do
    get_registration_form
    incorrect_registration
    click_link_or_button("Create Account")

    expect(page).to have_content("The form contains 2 errors")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Password can't be blank")
  end

  it "gets error messages if form is filled with invalid inputs" do
    get_registration_form
    incorrect_registration
    click_link_or_button("Create Account")
    expect(page).to have_content("Invalid input, please try again")
  end

  it "is taken back to whatever page they were on upon correct registration" do
    get_registration_form
    correct_registration
    click_link_or_button("Create Account")
    expect(current_path).to eq(root_path)
  end

  xit "must have a matching password confirmation" do
    get_registration_form
    fill_in("user[first_name]", with: "Pip" )
    fill_in("user[last_name]", with: "Pippo" )
    fill_in("user[display_name]", with: "Pip" )
    fill_in("user[email]", with: "pipmagnet@yahoo.com" )
    fill_in("user[password]", with: "password" )
    click_link_or_button("Create Account")

    expect(page).to have_content("The form contains 1 error")
    expect(page).to have_content("Password confirmation doesn't match Password")
  end

  it "receives an email confirmation upon sign up" do
    expect(ActionMailer::Base.deliveries.length).to eq(1)
  end
end
