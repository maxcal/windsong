class StationsController < ApplicationController

  load_and_authorize_resource

  # GET /stations/new
  def new
    @station = Station.new
  end

  # POST /stations
  def create
    @station = Station.new(create_params)

    respond_to do |format|
      if @station.save
        format.html { redirect_to station_path(@station), notice: 'Station was successfully created.' }
      else
        response.status = :unprocessable_entity
        format.html { render action: 'new' }
      end
    end
  end

  private

  def create_params
    params.require(:station).permit(:name, :hardware_uid)
  end

end