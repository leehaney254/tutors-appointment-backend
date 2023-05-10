class Api::V1::ReservationsController < ApplicationController
  before_action :authorized
  before_action :set_reservation, only: %i[show update destroy]

  # GET /reservations
  def index
    response = []
    @reservations = Reservation.all

    @reservations.each do |reservation|
      response << {
        id: reservation.id,
        user_id: reservation.user_id,
        tutor_id: reservation.tutor_id,
        date: reservation.date
      }
    end
    render json: response
  end

  # GET /reservations/1
  def show
    render json: @reservation
  end

  # POST /reservations
  def create
    @reservation = Reservation.new(reservation_params)

    if @reservation.save

      render json: { message: 'Created successfully' }, status: :created
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reservations/1
  def update
    if @reservation.update(reservation_params)
      render json: { message: 'Updated successfully' }
    else
      render json: @reservation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reservations/1
  def destroy
    @reservation.destroy
    return unless @reservation

    @reservation.destroy
    render json: { message: 'Deleted successfully' }
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_reservation
    @reservation = Reservation.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def reservation_params
    params.require(:reservation).permit(:user_id, :tutor_id, :date)
  end
end
