class Answer < ActiveRecord::Base
  belongs_to :question

  validates :answer_value, presence: true
end
