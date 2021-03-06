class CheckPoint < ActiveRecord::Base
  include AASM

  belongs_to :mentee
  has_one :question, dependent: :destroy
  has_many :answers, through: :question

  accepts_nested_attributes_for :question
  enum status: { unstarted: 0, started: 1, finished: 2 }

  scope :past_and_current, -> { where('start_date <= ?', Date.today) }

  validates :start_date, presence: true

  aasm :status do
    state :unstarted, :initial => true
    state :started
    state :finished

    event :start do
      before do
        touch(:started_at)
      end

      transitions :from => :unstarted, :to => :started
    end

    event :finish do
      transitions :from => :started, :to => :finished
    end
  end

  def should_have_started?
    start_date <= Date.today
  end

  def answer_of_mentor(mentor)
    answers.where(user_id: mentor.id).first
  end
end
