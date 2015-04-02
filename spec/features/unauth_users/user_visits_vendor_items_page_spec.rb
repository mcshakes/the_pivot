require 'rails_helper'

RSpec.describe "user visits vendor items", type: :feature do

  it "can see item details" do
    vendor = FactoryGirl.create(:vendor)
    item = FactoryGirl.create(:item, name: "Long Journey", vendor_id: vendor.id)
    visit vendor_items_path(slug: vendor.slug)
    within('.main') do 
      expect(page).to have_content("Title: Long Journey")
    end
  end

end
