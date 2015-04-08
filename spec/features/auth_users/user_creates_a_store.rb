require "rails_helper"

RSpec.feature "authenticated user tries to create a store", type: :feature do
  xit "can create a store when all relevant information is filled in" do
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit root_path
    click_link_or_button("Create a Store")
    fill_in
#     When I am signed in to the website
# And I click the dropdown in the navbar "My Account"
# And I choose "Create a Store"
# And I fill out "Store Name" with "Billy's BBQ"
# And I fill in my credit card information
# And I click "Create Store"
# And I click "Submit"
# And I am taken to a New Photographer/Vendor dashboard
# Then I have a store at "example.com/store/billys-bbq"
  end

  xit "cannot create a store when information is missing" do

#   When I am signed in to the website
# And I click the dropdown in the navbar "My Account"
# And I choose "Create a Store"
# And I don't fill in my credit card information or store name
# And I click "Submit"
# Then I see a message "Please fill in all of the required fields."
  end
end
