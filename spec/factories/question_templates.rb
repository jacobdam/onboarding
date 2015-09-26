FactoryGirl.define do
  factory :question_template do
    name { Faker::Lorem.sentence }
    worst_label "worst"
    best_label "best"
  end

end
