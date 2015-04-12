require 'rails_helper'

RSpec.describe Favorite, type: :model do
  before :each do
    @favorite = FactoryGirl.create(:favorite)
  end

  it 'should belong to an user' do
    expect(@favorite).to respond_to(:user)
  end

  it 'should belong to an item' do
    expect(@favorite).to respond_to(:item)
  end
  
  it "adds favorite photo upon clicking favorite button " do
    user = create(:user)
    expect(user.favorites.count).to eq(1)
  end
end