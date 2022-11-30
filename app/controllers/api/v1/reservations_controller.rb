class Api::V1::ReservationsController < ApplicationController
  before_action :set_reservation, only: %i[show update destroy]

  # GET /reservations
  def index
    @reservations = current_user.reservations.all

    render json: @reservations
  end

  # GET /reservations/1
  def show
    @reservation = current_user.reservations.find(params[:id])

    render json: @reservation
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)
    @fitness_activity = FitnessActivity.find(params[:fitness_activity_id])
    @reservation.user_id = current_user.id
    @reservation.fitness_activity_id = @fitness_activity.id

    if @reservation.save
      render json: @reservation, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  def update; end

  # DELETE /reservations/1
  def destroy
    @reservation.destroy
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:available_date_id)
  end
end
