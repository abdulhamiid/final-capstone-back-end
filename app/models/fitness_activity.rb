class FitnessActivity < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations, dependent: :destroy
  has_many :dates, dependent: :destroy

  has_many_attached :images

  validates :name, presence: true
  validates :description, presence: true
  validates :dates, presence: true
end
