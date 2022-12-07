require 'rails_helper'

RSpec.describe FitnessActivity, type: :model do
  context 'associations' do
    it('has many available dates') do
      fitness_activity = FitnessActivity.reflect_on_association(:available_dates)
      association = fitness_activity.macro
      expect(association).to eq(:has_many)
    end

    it('has many reservations') do
      fitness_activity = FitnessActivity.reflect_on_association(:reservations)
      association = fitness_activity.macro
      expect(association).to eq(:has_many)
    end
  end

  context 'validations' do
    it('is valid with valid attributes') do
      fitness_activity = FitnessActivity.new(name: 'Yoga', description: 'Yoga description')
      expect(fitness_activity).to be_valid
    end

    it('is not valid without a name') do
      fitness_activity = FitnessActivity.new(name: nil)
      expect(fitness_activity).to_not be_valid
    end

    it('is not valid without a description') do
      fitness_activity = FitnessActivity.new(description: nil)
      expect(fitness_activity).to_not be_valid
    end

    it('is not valid with a description shorter than 10 characters') do
      fitness_activity = FitnessActivity.new(description: 'Yoga')
      expect(fitness_activity).to_not be_valid
    end
  end
end