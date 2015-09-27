FactoryGirl.define do
  factory :mentee do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    skip_prepopulate_check_points true
    company
  end

end
