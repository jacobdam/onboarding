FactoryGirl.define do
  factory :check_point do
    start_date { Date.today }

    mentee

    after(:create) do |cp|
      create(:question, check_point: cp) unless cp.question
    end

    trait :started do
      start_date 1.days.ago
      status 1
    end

    trait :finished do
      start_date 10.days.ago
      status 2
    end

    trait :answered do
      after(:create) do |check_point|
        answer = create(:answer, question: check_point.question)
      end
    end
  end
end
