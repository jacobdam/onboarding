class Question < ActiveRecord::Base
  belongs_to :question_template
  belongs_to :check_point
  has_many :answers, dependent: :destroy
end
