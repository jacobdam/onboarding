class Mentee::ShowMentee
  attr_reader :mentee
  delegate :id, :name, :email, :mentors, to: :mentee
  delegate :competence_index,
    :average_expectation,
    :current_check_point_data,
    to: :calculator

  def initialize(mentee)
    @mentee = mentee
  end

  def progress_data
    [
      {
        name: 'Competence Index',
        data: calculator.competence_index_progress_data
      },

      {
        name: 'Average Expectation',
        data: calculator.average_expectation_progress_data
      }
    ]
  end

  private

  def calculator
    @calculator ||= Mentee::ExpectationCalculator.new(mentee)
  end
end
