class TablesController < ApplicationController

  def index
    @qry = if params[:restaurant_id].present?
      Table.where(restaurant_id: params[:restaurant_id])
    else
      Table
    end

    @tables = @qry.all

    render json: @tables, status: :ok
  end

  def show
    @table = Table.find_by(id: params['id'])

    render json: @table, status: :ok
  end

  def occupied
    @occupied_tables = Table.occupied_tables(
      params[:date_of_reservation],
      params[:start_at],
      params[:end_at]
    )

    render json: @occupied_tables, status: :ok
  end
end
