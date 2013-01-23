FactoryGirl.define do
  factory :user do
    sequence(:id) { |n| n+3 }
    sequence(:name) { |n|  "Person #{n}" }
    sequence(:email) { |n| "person_#{n}@gmail.com" }
    password               "password"
    password_confirmation  "password"
  end
end
