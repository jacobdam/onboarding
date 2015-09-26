FactoryGirl.define do
  factory :check_point do
    start_date { Date.today }

    mentee

    after(:create) do |cp|
      create(:question, check_point: cp)
    end
  end

end
