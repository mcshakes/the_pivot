require "rails_helper"

RSpec.describe "user manages personal account", type: :feature do
  def user_visits_account
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit account_path
  end

  def fill_in_address
    fill_in("address[street]", with: "123 Doc Drive")
    fill_in("address[city]", with: "Durango")
    fill_in("address[state]", with: "Colorado")
    fill_in("address[country]", with: "Mexico")
  end

  it "sees a button to add an address" do
    user_visits_account
    click_link_or_button("Update Your Address")
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
    fill_in_address
    click_link_or_button("Add Address")
    expect(page).to have_content("123 Doc Drive")
  end

  xit "deletes an address" do
    user_visits_account
    click_link_or_button("Update Your Address")
    click_link_or_button("Add a New Address")
    fill_in_address
    click_link_or_button("Add Address")
    expect(page).to have_content("123 Doc Drive")
  end

  it "must have a street" do
    user_visits_account
    click_link_or_button("Update Your Address")
    click_link_or_button("Add a New Address")

    fill_in("address[street]", with: "")
    fill_in("address[city]", with: "Durango")
    fill_in("address[state]", with: "Colorado")
    fill_in("address[country]", with: "Mexico")
    click_link_or_button("Add Address")

    expect(page).to have_content("Attributes missing.")
  end

  it "must have a city" do
    user_visits_account
    click_link_or_button("Update Your Address")
    click_link_or_button("Add a New Address")

    fill_in("address[street]", with: "123 Doc Drive")
    fill_in("address[city]", with: "")
    fill_in("address[state]", with: "Colorado")
    fill_in("address[country]", with: "Mexico")
    click_link_or_button("Add Address")

    expect(page).to have_content("Attributes missing.")
  end

  it "must have a state" do
    user_visits_account
    click_link_or_button("Update Your Address")
    click_link_or_button("Add a New Address")

    fill_in("address[street]", with: "123 Doc Drive")
    fill_in("address[city]", with: "Durango")
    fill_in("address[state]", with: "")
    fill_in("address[country]", with: "Mexico")
    click_link_or_button("Add Address")

    expect(page).to have_content("Attributes missing.")
  end

  it "must have a country" do
    user_visits_account
    click_link_or_button("Update Your Address")
    click_link_or_button("Add a New Address")

    fill_in("address[street]", with: "123 Doc Drive")
    fill_in("address[city]", with: "Durango")
    fill_in("address[state]", with: "Colorado")
    fill_in("address[country]", with: "")
    click_link_or_button("Add Address")

    expect(page).to have_content("Attributes missing.")
  end


  xit "edits an existing address" do
    user = create(:user)
    address = create(:address)
    user.addresses << address
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit account_path
    click_link_or_button("Update Your Address")
    expect(page).to have_content("237 Judson")
    click_link_or_button("Edit Existing Address")
    fill_in_address
    click_link_or_button("Update Address")
    expect(page).not_to have_content("237 Judson")
    expect(page).to have_content("123 Doc Drive")
  end
end
