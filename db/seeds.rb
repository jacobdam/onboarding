# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MAX_COMPANIES = 3
MAX_EMPLOYEES = 5
MAX_CHECK_POINTS = 10
MAX_MENTEES = 10

Company.destroy_all

company_count = Company.count

(MAX_COMPANIES - company_count).times do
  company = FactoryGirl.create(:company)
  employee_count = User.where(company: company).count

  FactoryGirl.create_list(:user, MAX_EMPLOYEES - employee_count, company: company)

  mentee_count = Mentee.where(company: company).count
  mentees = FactoryGirl.create_list(:mentee, MAX_MENTEES - mentee_count, company: company)

  mentees.each do |mentee|
    # QuestionTemplate::QUESTIONS.each_with_index do |question_text, i|
    #   check_point = FactoryGirl.create(:check_point, mentee: mentee, start_date: Date.today + i * 7, 
    #     question: FactoryGirl.build(:question, name: question_text))
    #   check_point.start! if i == 0
    # end
  end
end

#password is 'password'
admin = FactoryGirl.create(:user, :admin, email: 'user@email.com', company: Company.first)
admin = FactoryGirl.create(:user, :admin, email: 'admin@email.com', company: Company.first)
mentor_1 = FactoryGirl.create(:user, email: 'mentor1@email.com', company: Company.first)
mentor_2 = FactoryGirl.create(:user, email: 'mentor2@email.com', company: Company.first)
