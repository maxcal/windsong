class StationsController < ApplicationController

  load_and_authorize_resource

  before_filter :set_station, only: [:update]
  before_filter :set_view_context

  # @example
  #   GET /stations/new
  def new
    @station = Station.new
  end

  # @example
  #   POST /stations
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

  # @example
  #   GET /stations/:id
  def show
    # Rails does all the magic ...
  end

  # @example
  #   GET /stations/:id/edit
  def edit
    # Rails does all the magic ...
  end

  # @example
  #   PATCH /stations/:id
  def update
    respond_to do |format|
      if @station.update(update_params)
        format.html { redirect_to @station, notice: 'Station was successfully updated.' }
      else
        format.html { render action: 'edit', status: :unprocessable_entity }
      end
    end
  end

  # @example
  #   DESTROY /stations/:id
  def destroy
    @station.destroy
    redirect_to stations_path, notice: 'Station deleted.'
  end

  # @example
  #   GET /stations/find/:hardware_uid
  def find
    @station = Station.find_by(hardware_uid: params[:hardware_uid])

    respond_to do |format|
      format.html { redirect_to @station }
      format.json  { render json: @station, status: :found }
      # Support for legacy ardiuno units
      format.yaml {
        render text: {
          id:    @station.to_param,
          hw_id: @station.hardware_uid
        }.to_yaml,
          content_type: 'text/x-yaml'
        }
    end
  end

  private

  def set_station
    @station = Station.find(params[:id])
  end

  def set_view_context
    @station.try(:presenter, view_context)
  end

  def create_params
    params.require(:station).permit(:name, :hardware_uid, :custom_slug)
  end

  def update_params
    params.require(:station).permit(:name, :hardware_uid, :custom_slug)
  end

end