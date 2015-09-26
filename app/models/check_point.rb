class CheckPoint < ActiveRecord::Base
  include AASM

  belongs_to :mentee
  has_one :question, dependent: :destroy
  accepts_nested_attributes_for :question
  enum status: { unstarted: 0, started: 1, finished: 2 }

  aasm :status do
    state :unstarted, :initial => true
    state :started
    state :finished

    event :start do
      transitions :from => :unstarted, :to => :started
    end

    event :finish do
      transitions :from => :started, :to => :finished
    end

  end

  def should_have_started?
    start_date <= Date.today
  end
end
