class Reservation < ApplicationRecord
  belongs_to :fitness_activity
  belongs_to :available_date, dependent: :destroy
  belongs_to :user

  validates :user_id, presence: true
  validates :fitness_activity_id, presence: true
end
