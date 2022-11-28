class ReservationSerializer < ActiveModel::Serializer
  attributes :id, :user_id, :fitness_activity_id, :date_id
  belongs_to :user
  belongs_to :fitness_activity

  has_one :date
end
