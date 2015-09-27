class Mentee < ActiveRecord::Base
  belongs_to :company
  has_many :check_points, dependent: :destroy
  has_many :mentorships, dependent: :destroy
  has_many :mentors, through: :mentorships, source: :user

  validates :email, :name, presence: true
  validates :email, uniqueness: { scope: :company_id }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }

  def current_check_point
    check_points.where(status: CheckPoint.statuses[:started]).first
  end
end
