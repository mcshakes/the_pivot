FactoryGirl.define do
  factory :user do
    first_name "Richard"
    last_name "Mejia"
    email "richard@example.com"
    password "hello"
    shipping_address "1425 Del Clair Rd, Durango, CO 80521"
    billing_address "1425 Del Clair Rd, Durango, CO 80521"
    credit_card "8675 3096 1099 7724"
  end

  factory :admin, class: User do
    first_name "Admin"
    last_name "Mejia"
    email "admin@example.com"
    password "admin"
    role "admin"
  end
end
