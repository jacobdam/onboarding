class Dashboard::ShowDashboard
  def initialize(user)
    @user = user
  end

  def answered_check_points
    @answered_check_points ||= wrapped_check_points(unwrapped_answered_check_points)
  end

  def unanswered_check_points
    @unanswered_check_points ||= wrapped_check_points(unwrapped_unanswered_check_points)
  end

  private

  attr_reader :user

  def current_check_points
    @current_check_points ||= user.mentees.includes(check_points: :answers).map do |mentee|
      mentee.current_check_point
    end.compact
  end

  def unwrapped_answered_check_points
    @unwrapped_answered_check_points ||= current_check_points.select do |check_point|
      check_point.answer_of_mentor(user).present?
    end
  end

  def unwrapped_unanswered_check_points
    @unwrapped_unanswered_check_points ||= current_check_points - unwrapped_answered_check_points
  end

  def wrapped_check_points(check_points)
    check_points.map do |check_point|
      CheckPoint::DashboardView.new(check_point, user)
    end
  end
end
