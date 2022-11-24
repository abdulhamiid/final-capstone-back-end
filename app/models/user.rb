class User < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :fitness_activities, through: :reservations, dependent: :destroy
end
