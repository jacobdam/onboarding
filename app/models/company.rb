class Company < ActiveRecord::Base
  validates :name, presence: true

  has_many :users, dependent: :destroy
  has_many :mentees, dependent: :destroy
end
