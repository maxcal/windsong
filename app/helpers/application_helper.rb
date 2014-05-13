module ApplicationHelper

  def title
    @title ? "#{@title} | Windsong" : 'Windsong'
  end

end
