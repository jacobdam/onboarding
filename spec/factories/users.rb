FactoryGirl.define do
  factory :user do
    is_admin false
    company
    email { Faker::Internet.email }
    full_name { Faker::Name.name }
    password 'password'
    password_confirmation 'password'

    trait :admin do
      is_admin true
    end
  end
end
