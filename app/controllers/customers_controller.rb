class CustomersController < ApplicationController
  def index
    @custs = Customer.all

    render json: @custs, status: :ok
  end

  def show
    @cust = Customer.find_by(id: params[:id])

    render json: @cust, status: :ok
  end
end
