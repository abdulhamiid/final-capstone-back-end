class Api::V1::AvailableDatesController < ApiController
  before_action :set_fitness_activity, only: [:index]

  def index
    @dates = @fitness_activity.available_dates.all
    render json: @dates, status: 200, include: %i[fitness_activity]
  end

  private

  def set_fitness_activity
    @fitness_activity = FitnessActivity.find(params[:fitness_activity_id])
  end
end
