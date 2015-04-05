require "rails_helper"
require "support/factory_girl"

RSpec.describe User, type: :model do
  it "is valid" do
    user = create(:user)
    expect(user).to be_valid
  end

  it "is invalid without a first name" do
    user = build(:user, first_name: nil)
    expect(user).not_to be_valid
  end

  it "is invalid without a last name" do
    user = build(:user, last_name: nil)
    expect(user).not_to be_valid
  end

  it "is valid without a display name" do
    user = build(:user, display_name: nil)
    expect(user).to be_valid
  end

  it "is invalid without an email" do
    user = build(:user, email: nil)
    expect(user).not_to be_valid
  end

  it "is invalid without a unique email address" do
    user = build(:user, email: nil)
    duplicate_user = user.dup
    expect(duplicate_user).not_to be_valid
  end

  it "is invalid without a password" do
    user = build(:user, password: nil)
    expect(user).not_to be_valid
  end

  it "has an array of orders" do
    user = create(:user)
    order = user.orders.create(user_id: user.id)
    expect(user.orders).to eq([order])
  end

  it "is invalid without a role" do
    user = build(:user, role: nil)
    expect(user).not_to be_valid
  end

  it "has an initial role of default" do
    user = create(:user)
    expect(user.roles.first).to eq("default")
  end

  it "has a reasonable email length" do
    user_email = "a" * 200 + "@example.com"
    user = User.create(first_name: "bo", last_name: "bunson",
                        email: user_email, password: "password" )
    expect(user).not_to be_valid
  end

  it "should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      user = create(:user, email: valid_address)
      expect(user).to be_valid
    end
  end

  it "should reject invalid email formats" do
    user1= User.create(first_name: "bo", last_name: "bunson",
                        email: "user_at_foo.org", password: "password" )
    user2= User.create(first_name: "bop", last_name: "bupkiss",
                        email: "user.name@example.", password: "password" )
    expect(user1).not_to be_valid
    expect(user2).not_to be_valid
  end

end
