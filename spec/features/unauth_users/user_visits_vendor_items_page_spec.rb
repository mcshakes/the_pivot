require 'rails_helper'

RSpec.describe "user visits vendor items", type: :feature do

  it "can see item details" do
    vendor = FactoryGirl.create(:vendor)
    item = FactoryGirl.create(:item, name: "Long Journey", vendor_id: vendor.id)
    visit vendor_items_path(slug: vendor.slug)
    within('.main-vendor-items') do
      expect(page).to have_content("Long Journey")
    end
  end

  it "sees a different store every time" do
    vendor = FactoryGirl.create(:vendor)
    item = FactoryGirl.create(:item, name: "Long Journey", vendor_id: vendor.id)
    visit vendor_items_path(slug: vendor.slug)
    within('.main-vendor-items') do
      expect(page).to have_content("Long Journey")
    end
    vendor2 = Vendor.create(name: "New Vendor", description: "cool stuff", credit_card: "1111222233334444", user_id: 2)
    item2 = FactoryGirl.create(:item, name: "Short Journey", vendor_id: vendor2.id)
    visit vendor_items_path(slug: vendor2.slug)
    within('.main-vendor-items') do
      expect(page).to have_content("Long Journey")
    end
  end

end
