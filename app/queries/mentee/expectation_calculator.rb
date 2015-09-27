class Mentee::ExpectationCalculator
  attr_reader :mentee

  def initialize(mentee)
    @mentee = mentee
  end

  def competence_index
    competence_index_by_check_point(current_check_point)
  end

  def average_expectation
    average_expectation_by_check_point(current_check_point)
  end

  def current_check_point_data
    answers.group(:answer_value).count
  end

  def competence_index_progress_data
    past_and_current_check_points.map do |check_point|
      [check_point.start_date, competence_index_by_check_point(check_point)]
    end
  end

  def average_expectation_progress_data
    past_and_current_check_points.map do |check_point|
      [check_point.start_date, average_expectation_by_check_point(check_point)]
    end
  end

  private

  delegate :current_check_point, to: :mentee
  delegate :answers, to: :current_check_point

  def average_expectation_by_check_point(check_point)
    if check_point.answers.count > 0
      total_point = answers.pluck(:answer_value).sum
      total_point / answers.count
    else
      0
    end
  end

  def competence_index_by_check_point(check_point)
    check_point.answers.inject(0) do |result, answer|
      if answer.answer_value > 8
        result += 1
      elsif answer.answer_value > 6
        result
      else
        result -= 1
      end
    end
  end

  def past_and_current_check_points
    mentee.check_points.past_and_current.includes(:answers)
  end
end
