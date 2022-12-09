require 'rails_helper'

RSpec.describe Reservation, type: :model do
  before(:example) do
    @user = User.create!(name: 'John', email: "#{DateTime.now}@gmail.com", password: 'password')
    @fitness_activity = FitnessActivity.create(name: 'Yoga', description: 'Yoga is a group of physical, mental, and spiritual practices or disciplines which originated in ancient India.')
    @available_date = AvailableDate.create(date: '2021-01-01', fitness_activity_id: @fitness_activity.id)
  end

  describe 'validations' do
    it 'is invalid without a date' do
      @reservation = Reservation.new(available_date_id: nil)
      @reservation.user_id = @user.id
      @reservation.fitness_activity_id = @fitness_activity.id

      expect(@reservation).to_not be_valid
    end
  end

  describe 'validations' do
    it 'is valid with a date' do
      @reservation = @user.reservations.new(available_date_id: @available_date.id)
      @reservation.user_id = @user.id
      @reservation.fitness_activity_id = @fitness_activity.id

      expect(@reservation).to be_valid
    end
  end

  describe 'associations' do
    it 'belongs to a user' do
      relation = described_class.reflect_on_association(:user)
      expect(relation.macro).to eq(:belongs_to)
    end
  end

  describe 'associations' do
    it 'belongs to a fitness activity' do
      relation = described_class.reflect_on_association(:fitness_activity)
      expect(relation.macro).to eq(:belongs_to)
    end
  end

  describe 'associations' do
    it 'belongs to an available date' do
      relation = described_class.reflect_on_association(:available_date)
      expect(relation.macro).to eq(:belongs_to)
    end
  end
end
