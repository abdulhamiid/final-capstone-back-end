class Api::V1::ReservationsController < ApplicationController
  load_and_authorize_resource
  before_action :set_reservation, only: %i[show update destroy]

  # GET /reservations
  def index
    @reservations = current_user.reservations.all

    render json: @reservations, status: 200, include: %i[fitness_activity]
  end

  # GET /reservations/1
  def show
    @reservation = current_user.reservations.find(params[:id])

    render json: @reservation, status: 200, include: %i[fitness_activity]
  end

  # POST /reservations
  def create
    @reservation = current_user.reservations.new(reservation_params)
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
    @reservation = current_user.reservations.find(params[:id])
    @reservation.destroy

    if @reservation.destroy
      render json: { message: 'Reservation deleted' }
    else
      render json: { message: 'Reservation not deleted' }
    end
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
