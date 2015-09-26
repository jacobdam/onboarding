# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

MAX_COMPANIES = 3
MAX_EMPLOYEES = 5
MAX_QUESTIONS = 12
MAX_CHECK_POINTS = 10
MAX_MENTEES = 10

company_count = Company.count

(MAX_COMPANIES - company_count).times do
  company = FactoryGirl.create(:company)
  employee_count = User.where(company: company).count
  check_point_count = CheckPoint.where(company: company).count

  FactoryGirl.create_list(:user, MAX_EMPLOYEES - employee_count, company: company)

  (MAX_CHECK_POINTS - check_point_count).times do
    check_point = FactoryGirl.create(:check_point, company: company)
    question_count = Question.where(check_point: check_point).count

    FactoryGirl.create_list(:question, MAX_QUESTIONS - question_count, check_point: check_point)
  end

  mentee_count = Mentee.where(company: company).count
  FactoryGirl.create_list(:mentee, MAX_MENTEES - mentee_count, company: company)
end
