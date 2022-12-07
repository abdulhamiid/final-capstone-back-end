class Api::V1::FitnessActivitiesController < ApiController
  def index
    @fitness_activities = FitnessActivity.all
    render json: @fitness_activities, status: 200, include: %i[available_dates reservations images_urls]
  end

  def show
    @fitness_activity = FitnessActivity.find(params[:id])
    render json: @fitness_activity, status: 200, include: %i[available_dates reservations images_urls]
  end

  def create
    @fitness_activity = FitnessActivity.new(name: fitness_activity_params[:name],
                                            images: fitness_activity_params[:images], description: fitness_activity_params[:description], amount: fitness_activity_params[:amount])
    if fitness_activity_params[:dates].present?
      if @fitness_activity.save
        @fitness_activity.images.attach(fitness_activity_params[:images])
        fitness_activity_params[:dates].split(',').each do |date|
          @fitness_activity.available_dates.create(date: date)
        end
        render json: { message: "New fitness activity, #{@fitness_activity.name}, created successfully", fitness_activity: @fitness_activity }, status: :created
      else
        render json: { errors: @fitness_activity.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: 'Please select at least one date of availability for this activity' },
             status: :unprocessable_entity
    end
  end

  def destroy
    @fitness_activity = FitnessActivity.find(params[:id])
    @fitness_activity.destroy
    render json: { message: "Fitness activity, #{@fitness_activity.name}, deleted successfully" }, status: 200
  end

  def update
    @fitness_activity = FitnessActivity.find(params[:id])
    if @fitness_activity.update(name: fitness_activity_params[:name], images: fitness_activity_params[:images],
                                description: fitness_activity_params[:description], amount: fitness_activity_params[:amount])
      @fitness_activity.available_dates.destroy_all
      fitness_activity_params[:dates].each do |date|
        @fitness_activity.available_dates.create(date:)
      end
      render json: { message: "Fitness activity, #{@fitness_activity.name}, updated successfully", fitness_activity: @fitness_activity }, status: 200
    else
      render json: { errors: @fitness_activity.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def fitness_activity_params
    params.require(:fitness_activity).permit(:name, :description, :amount, :dates, images: [])
  end
end
