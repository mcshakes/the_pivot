FactoryGirl.define do
  factory :vendor do
    name "Ansel Adams"
    description "black and white"
    credit_card "4242 4242 4242 4242"
  end

  factory :vendor1 do
    name "Ansel Adam's"
    description "black and white"
    credit_card "4242 4242 4242 4242"
  end
end
