class ServersController < ApplicationController
  def index
    @servers = Server.all

    render json: @servers, status: :ok
  end

  def show
    @server = Server.find_by(id: params[:id])

    render json: @server, status: :ok
  end
end
