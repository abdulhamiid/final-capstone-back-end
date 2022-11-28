class FitnessActivitySerializer < ActiveModel::Serializer
  attributes :id, :name, :description, :amount, :images, :images_urls

  has_many :available_dates
end
