FactoryGirl.define do
  factory :answer do
    question { Faker::Lorem.sentence }
    answer_value 1
  end
end
