FactoryGirl.define do
  factory :mentee do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    company
  end

end
