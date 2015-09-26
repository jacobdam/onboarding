class Mentorship < ActiveRecord::Base
  belongs_to :user
  belongs_to :mentee
end
