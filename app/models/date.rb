class Date < ApplicationRecord
  belongs_to :fitness_activity
  has_one :reservation, dependent: :destroy
end