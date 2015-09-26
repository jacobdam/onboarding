class Mentee < ActiveRecord::Base
  belongs_to :company
  has_many :check_points, dependent: :destroy
  validates :email, :name, presence: true
  validates :email, uniqueness: { scope: :company_id }
  validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i }
end
