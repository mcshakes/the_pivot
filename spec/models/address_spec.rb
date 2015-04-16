require 'rails_helper'

RSpec.describe Address, type: :model do

  it "is valid" do
    address = create(:address)
    expect(address).to be_valid
  end

  it "is invalid without a street" do
    address = build(:address, street: nil)
    expect(address).not_to be_valid
  end

  it "is invalid without a street" do
    address = build(:address, city: nil)
    expect(address).not_to be_valid
  end

  it "is invalid without a street" do
    address = build(:address, state: nil)
    expect(address).not_to be_valid
  end

  it "is invalid without a street" do
    address = build(:address, country: nil)
    expect(address).not_to be_valid
  end
end
