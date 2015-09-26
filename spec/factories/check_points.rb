FactoryGirl.define do
  factory :check_point do
    start_date { Date.today }

    mentee

    after(:create) do |cp|
      create(:question, check_point: cp)
    end

    trait :started do
      status 1
    end

    trait :answered do
      after(:create) do |check_point|
        answer = create(:answer, question: check_point.question)
      end
    end
  end
end
