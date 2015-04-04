require "rails_helper"
require "support/factory_girl"

RSpec.describe Role, type: :model do
  it "is valid" do
    role = create(:role)
    expect(role).to be_valid
  end
end
