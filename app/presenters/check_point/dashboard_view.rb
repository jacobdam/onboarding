class CheckPoint::DashboardView
  attr_reader :check_point, :user
  delegate :start_date, :mentee, :question, to: :check_point
  delegate :name, to: :question, prefix: true

  def initialize(check_point, user)
    @check_point = check_point
    @user = user
  end

  def answer
    check_point.answer_of_mentor(user).answer_value
  end
end
