FactoryGirl.define do
  factory :vendor do
    name "Ansel Adams"
    description "black and white"
    credit_card "4242 4242 4242 4242"
    user_id :user
  end
end
