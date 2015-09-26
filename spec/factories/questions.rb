FactoryGirl.define do
  factory :question do
    check_point
    name { Faker::Lorem.sentence }
  end

end
