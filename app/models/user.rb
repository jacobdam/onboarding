class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :invitable, :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :invitable

  belongs_to :company
  has_many :mentorships, dependent: :destroy
  has_many :mentees, through: :mentorships

  scope :mentors, -> { where(is_admin: false) }
end
