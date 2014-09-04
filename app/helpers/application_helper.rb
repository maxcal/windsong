module ApplicationHelper

  def title
    @title ? "#{@title} | Windsong" : 'Windsong'
  end


  def t_models(model)
    model.model_name.human(count: 2)
  end

end
