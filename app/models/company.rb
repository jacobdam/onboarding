class Company < ActiveRecord::Base
  validates :name, presence: true

  has_many :users, dependent: :destroy
  has_many :mentors, -> { mentors }, class_name: 'User'
  has_many :mentees, dependent: :destroy
end
