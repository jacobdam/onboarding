class Mentee < ActiveRecord::Base
  belongs_to :company
  has_many :check_points, ->{ order(start_date: 'asc') }, dependent: :destroy
  has_many :mentorships, dependent: :destroy
  has_many :mentors, through: :mentorships, source: :user

  validates :email, :name, presence: true
  validates :email, uniqueness: { scope: :company_id }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  after_create :prepopulate_check_points

  def current_check_point
    check_points.where(status: CheckPoint.statuses[:started]).first
  end

  private

  def prepopulate_check_points
    QuestionTemplate::QUESTIONS.each_with_index do |question_name, index|
      check_point = check_points.build(start_date: Date.today + index * 7)
      check_point.build_question(name: question_name)
    end

    save!
    check_points.first.start!
  end

end
