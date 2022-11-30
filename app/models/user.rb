class User < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :fitness_activities, through: :reservations, dependent: :destroy

  validates :name, presence: true, length: { maximum: 25 }
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, length: { minimum: 6 }
end
