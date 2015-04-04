require 'rails_helper'

RSpec.describe "user visits vendor index page", type: :feature do

  it "can see vendors" do
    vendor = FactoryGirl.create(:vendor)
    item = FactoryGirl.create(:item, name: "Long Journey", vendor_id: vendor.id)
    
    visit vendors_path
    within('.container') do
      expect(page).to have_content("Ansel Adams")
      expect(page).to have_content("black and white")
    end
  end
end
