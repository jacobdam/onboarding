class CheckPoint < ActiveRecord::Base
  belongs_to :company
  has_many :questions, dependent: :destroy
end
