require 'rails_helper'

RSpec.describe FavoriteItem, type: :model do
  before :each do
    @favorite_item = FactoryGirl.create(:favorite_item)
  end

  it 'should belong to an user' do
    expect(@favorite_item).to respond_to(:user)
  end

  it 'should belong to an item' do
    expect(@favorite_item).to respond_to(:item)
  end
  
  it "adds favorite photo upon clicking favorite button " do
    user = create(:user)
    expect(user.favorite_items.count).to eq(1)
  end
end