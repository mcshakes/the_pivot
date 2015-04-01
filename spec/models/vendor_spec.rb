require "rails_helper"
require "support/factory_girl"

RSpec.describe Vendor, type: :model do
  it "is valid" do
    vendor = create(:vendor)
    expect(vendor).to be_valid
  end

  it "is invalid without a name" do
    vendor = build(:vendor, name: nil)
    expect(vendor).not_to be_valid
  end
end
