require "rails_helper"
require "support/factory_girl"

RSpec.describe Vendor, type: :model do
  it "is valid" do
    vendor = create(:vendor)
    expect(vendor).to be_valid
  end

  it "is has a description" do
    vendor = create(:vendor)
    assert vendor.description
  end

  it "is unique" do
    vendor = create(:vendor)
    vendor2 = build(:vendor)
    vendor2.save
    expect(vendor2).not_to be_valid
  end

  it "is associated with a user" do
    vendor = build(:vendor)
    expect(vendor).to respond_to(:user)
  end

  it "is invalid without a name" do
    vendor = build(:vendor, name: nil)
    expect(vendor.id).to eq(nil)
  end

  it "is invalid without a description" do
    vendor = build(:vendor, description: nil)
    expect(vendor).to_not be_valid
  end
end
