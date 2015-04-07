require "rails_helper"

RSpec.describe "authenticated user manages personal account", type: :feature do

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

  it "clicks to go to account page in the nav bar" do
    user = create(:user, first_name: "Bob", last_name: "Bobbyson", email: "bobson@hotmail.com", password: "password")
    order = create(:order)
    item = create(:item)
    item2 = create(:item, :for_sale, name: "Food Glorious Food")
    order.items << item
    user.orders << order

    user_sign_in(user)
    expect(page).to have_content("Sign in successful")
    click_link_or_button("Account")
    expect(current_path).to eq(account_path)
    expect(page).to have_content("My Account")
    save_and_open_page

    # save_and_open_page
    # click_link_or_button("Sign In")
  end
end

#
# RSpec.feature "user visits account", type: :feature do
#   it "can see order details and click on order items" do
#     user = create(:user)
#     order = create(:order)
#     item = create(:item)
#     order.items << item
#     user.orders << order
#     allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
#
#     visit account_path
#     expect(page).to have_content("1 Salted Caramel Peanut Butter Cup: $6.00")
#     expect(page).to have_content("cancelled")
#     expect(page).to have_content("March 14, 2015, 3:08 PM")
#     expect(page).to have_content("cancelled as of")
#     click_link_or_button("Salted Caramel Peanut Butter Cup")
#     expect(page).to have_content("Salted caramel ice cream with chopped peanut butter cups")
#   end
# end
