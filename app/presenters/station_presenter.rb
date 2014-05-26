class StationPresenter < Presenter

  # @return (String)
  def to_s
    @object.name
  end

  # @return (String)
  def resource_name
    "station"
  end
end