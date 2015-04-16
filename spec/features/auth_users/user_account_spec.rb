require "rails_helper"

RSpec.feature "user visits account", type: :feature do
  it "can see order details and click on order items" do
    user = create(:user, first_name: "cat", last_name: "meow", email: "cat@example.com", password: "mrow")
    order = create(:order)
    vendor = create(:vendor)
    item = create(:item)
    vendor.items << item
    order.items << item
    user.orders << order
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit account_path
    expect(page).to have_content("1 Salted Caramel Peanut Butter Cup")
    expect(page).to have_content("Ansel Adams")
    click_link_or_button("Salted Caramel Peanut Butter Cup")
    expect(page).to have_content("Salted caramel ice cream with chopped peanut butter cups")
  end

  it "cannot see account if not signed in" do
    visit account_path
    expect(page).to have_content("You must sign in to see your account.")
  end
    
end
