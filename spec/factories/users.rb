FactoryGirl.define do
  factory :user do
    is_admin false
    email { Faker::Internet.email }
    full_name { Faker::Name.name }
    company
    password 'password'
    password_confirmation 'password'

    trait :admin do
      is_admin true
    end
  end
end
