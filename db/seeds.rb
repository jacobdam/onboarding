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

Company.destroy_all

company_count = Company.count

#password is 'password'
user = FactoryGirl.create(:user, :admin, email: 'user@email.com', company: nil)

(MAX_COMPANIES - company_count).times do
  company = FactoryGirl.create(:company)

  user.update!(company: company) unless user.company

  employee_count = User.where(company: company).count

  FactoryGirl.create_list(:user, MAX_EMPLOYEES - employee_count, company: company)

  mentee_count = Mentee.where(company: company).count
  mentees = FactoryGirl.create_list(:mentee, MAX_MENTEES - mentee_count, company: company)

  mentees.each do |mentee|
    MAX_CHECK_POINTS.times do |i|
      FactoryGirl.create(:check_point, mentee: mentee, start_date: Date.today + i * 7)
    end
  end
end
