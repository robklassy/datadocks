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

    render json: {}, status: :ok
  end
end
