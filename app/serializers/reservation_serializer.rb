class ReservationSerializer < ActiveModel::Serializer
  attributes :id
  has_one :fitness_activity
  has_one :available_date
  has_one :user
end
