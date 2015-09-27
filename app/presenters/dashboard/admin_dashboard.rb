class Dashboard::AdminDashboard
  attr_reader :user
  delegate :company, to: :user

  def initialize(user)
    @user = user
  end

  def data
    company.mentees.includes(:check_points).map do |mentee|
      {
        name: mentee.name,
        data: mentee_calculator(mentee).average_expectation_progress_data
      }
    end
  end

  private

  def mentee_calculator(mentee)
    Mentee::ExpectationCalculator.new(mentee)
  end
end
