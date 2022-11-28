class FitnessActivity < ApplicationRecord
  has_many :reservations, dependent: :destroy
  has_many :users, through: :reservations, dependent: :destroy
  has_many :available_dates, dependent: :destroy

  has_many_attached :images

  validates :name, presence: true
  validates :description, presence: true, length: { minimum: 10 }

  def images_urls
    return unless images.attached?

    images.map do |image|
      Rails.application.routes.url_helpers.rails_blob_path(image, only_path: true)
    end
  end
end
