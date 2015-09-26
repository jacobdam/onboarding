FactoryGirl.define do
  factory :check_point do
    started_at { Faker::Time.backward(14, :evening) }

    mentee

    after(:create) do |cp|
      create(:question, check_point: cp)
    end
  end

end
