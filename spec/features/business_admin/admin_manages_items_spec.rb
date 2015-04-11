require "rails_helper"

RSpec.describe "admin managing items", type: :feature do

  it "must be admin to access create item page" do
    create_admin_user_and_vendor
    visit new_vendor_item_path(slug: @vendor.slug)

    expect(page).to have_content("Add a New Photograph")
  end

  it "user cannot access create item page" do
    create_admin_user_and_vendor
    user = create(:user)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
    visit new_vendor_item_path(slug: @vendor.slug)
    expect(page).to have_content("You are not authorized to access this page")
  end

  it "won't allow the admin of another store to edit items" do
    admin1 = create(:admin)
    vendor1 = create(:vendor)
    admin1.vendors << vendor1
    other_admin = User.create(first_name: "Hey", last_name: "There", email: "admin2@example.com",
                              password: "admin", role: "store_admin")
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(other_admin)
    visit new_vendor_item_path(slug: vendor1.slug)

    expect(page).to have_content("You are not authorized to access this page")
  end

  it "can create new item" do
    create_admin_user_and_vendor
    category = create(:category)
    visit new_vendor_item_path(slug: @vendor.slug)
    fill_in "item[name]", with: "snuggly cats"
    fill_in "item[description]", with: "such cute"
    fill_in "item[price]", with: "600"
    page.check('category_ids_')
    click_link_or_button "Submit"
    # save_and_open_page

    expect(page).to have_content("snuggly cats")
    expect(page).to have_content("Your photograph has been added!")
  end

  it "cannot create item without valid name" do
    create_admin_user_and_vendor
    visit new_vendor_item_path(slug: @vendor.slug)
    fill_in "item[description]", with: "double chocolate"
    fill_in "item[price]", with: "600"
    click_link_or_button "Submit"

    expect(current_path).to eq(new_vendor_item_path(slug: @vendor.slug))
    expect(page).to have_content("Attributes missing")
  end

  xit "can access edit item from individual item page" do
    create_admin_user_and_vendor
    item = create(:item)
    item.categories << create(:category)
    visit vendor_item_path(slug: @vendor.slug, id: item.id)
    click_link_or_button "Edit Item"
    fill_in "item[name]", with: "fudge"
    fill_in "item[description]", with: "double chocolate"
    fill_in "item[price]", with: "600"
    click_link_or_button "Submit"

    assert page.current_path == "/menu/items/fudge"
    expect(page).to have_content("Item has been successfully updated!")
  end

  xit "cannot modify item if attribute is missing" do
    create_admin_user_and_vendor
    item = create(:item)
    visit edit_menu_item_path(item)
    fill_in "item[name]", with: "fudge"
    fill_in "item[description]", with: ""
    fill_in "item[price]", with: "600"
    click_link_or_button "Submit"
    expect(page).to have_content("Attributes missing.")
  end

  xit "cannot create item if no category is selected" do
    create_admin_user_and_vendor
    create(:item)
    visit new_vendor_item_path(slug: @vendor.slug)
    fill_in "item[name]", with: "fudge"
    fill_in "item[description]", with: ""
    fill_in "item[price]", with: "600"
    click_link_or_button "Submit"
    within("div.alert-danger") do
      expect(page).to have_content("Attributes missing")
    end
  end

  xit "can upload photo when creating new item" do
    create_admin_user_and_vendor
    visit new_vendor_item_path
    fill_in "item[name]", with: "fudge"
    fill_in "item[description]", with: "double chocolate"
    fill_in "item[price]", with: "600"
    # attach_file "item[image]", "app/assets/images/cookie-monster.jpg"
    click_link_or_button "Submit"
    expect(current_path).to eq("/menu/items/fudge")
    # expect(page).to have_css("img[alt='Cookie monster']")
  end

  xit "can retire an item" do
    create_admin_user_and_vendor
    item = create(:item)
    item.categories << create(:category)
    visit edit_menu_item_path(item)
    select 'retired', from: 'item_status'
    click_link_or_button "Submit"
    expect(page).to have_content("Item has been successfully updated!")
    expect(item.reload.status).to eq("retired")
  end

  private

  def create_admin_user_and_vendor
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @vendor = create(:vendor)
    @admin.vendors << @vendor
  end
end
