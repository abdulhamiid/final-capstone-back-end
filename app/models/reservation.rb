class Reservation < ApplicationRecord
  belongs_to :user
  belongs_to :fitness_activity

  has_one :date, dependent: :destroy

  validates :user_id, presence: true
  validates :fitness_activity_id, presence: true
end
