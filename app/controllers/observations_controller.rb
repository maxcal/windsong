class ObservationsController < ApplicationController

  load_and_authorize_resource

  before_filter :set_station

  # @example
  #   GET /stations/:station_id/observations
  def index
    @observations = @station.observations.all
  end

  # @example
  #   POST /stations/:station_id/observations
  def create
    if @observation.save
      redirect_to station_observations_path(station_id: @station.to_param)
    else
      render nothing: true, status: :unprocessable_entity
    end
  end

  private

  def set_station
    @station = Station.find(params[:station_id])
  end

  def create_params
    params.require(:observation).permit(:min, :speed, :gust, :direction, :temperature)
  end
end