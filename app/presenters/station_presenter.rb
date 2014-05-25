class StationPresenter < Presenter

  def to_s
    @object.name
  end

  def model_name_humanized
    "station"
  end

end