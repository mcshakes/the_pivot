require "rails_helper"

RSpec.describe "admin updates business details", type: :feature do

  it "sees business info when clicking on individual store" do
    create_admin_user_and_vendor
    visit vendor_items_path(slug: @vendor.slug)
    expect(page).to have_content("Welcome to #{@vendor.name}'s Photo Gallery")
    expect(page).to have_content("#{@vendor.description}")
  end


  private

  def create_admin_user_and_vendor
    @admin = create(:admin)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@admin)
    @vendor = create(:vendor)
    @admin.vendors << @vendor
  end

end
