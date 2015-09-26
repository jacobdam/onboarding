FactoryGirl.define do
  factory :user do
    is_admin false
    company
    email { Faker::Internet.email }
    full_name { Faker::Name.name }
    password 'password'
    password_confirmation 'password'

    trait :admin do
      is_admin true
    end

    trait :mentor_with_mentee do
      after(:create) do |mentor|
        mentee = create(:mentee)
        mentorship = create(:mentorship, mentee_id: mentee.id, user_id: mentor.id)
      end
    end
  end
end
