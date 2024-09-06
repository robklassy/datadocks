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
    @res = if params[:optimized].to_s == 'true'
      create_first_come
    else
      create_optimized
    end

    render json: {}, status: :ok
  end

  private

  def create_first_come
  end

  def create_optimized
  end
end
