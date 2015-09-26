class CheckPoint < ActiveRecord::Base
  belongs_to :mentee
  has_one :question, dependent: :destroy
  accepts_nested_attributes_for :question
end
