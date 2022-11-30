class AvailableDateSerializer < ActiveModel::Serializer
  attributes :id, :date, :reserved

  belongs_to :fitness_activity

  def date
    object.date.strftime('%Y-%m-%d')
  end
end
