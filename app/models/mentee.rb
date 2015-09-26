class Mentee < ActiveRecord::Base
  belongs_to :company
  has_many :check_points, dependent: :destroy
end
