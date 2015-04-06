FactoryGirl.define do
  factory :item do
    name "Salted Caramel Peanut Butter Cup"
    description "Salted caramel ice cream with chopped peanut butter cups"
    price 6.00

    trait :retired do
      status "retired"
    end

    trait :for_sale do
      status "active"
    end

    trait :sold do
      status "sold"
    end
  end
end
