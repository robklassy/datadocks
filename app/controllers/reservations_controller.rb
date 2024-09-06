class ReservationsController < ApplicationController
  def index
    @reservations = if params[:restaurant_id].present?
      Reservation.where(restaurant_id: params[:restaurant_id]).all
    else
      Reservation.all
    end

    render json: @reservations, status: :ok
  end

  def show
    @res = Reservation.find_by(id: params[:id])

    render json: @res, status: :ok
  end

  def create
    params.permit!

    @res = if params[:optimized].to_s == 'true'
      Reservation.create_reservation_optimized(params) || {}
    else
      Reservation.create_reservation_first_come(params) || {}
    end

    render json: @res, status: :ok
  end
  
end
