class CheckPoint < ActiveRecord::Base
  belongs_to :mentee
  has_one :question, dependent: :destroy
end
