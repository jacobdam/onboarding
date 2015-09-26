FactoryGirl.define do
  factory :check_point do
    started_at { Faker::Time.backward(14, :evening) }
  end

end
