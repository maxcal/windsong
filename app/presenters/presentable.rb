module Presentable



  # Memoized getter that creates a presenter for model
  # @param context the view context
  def presenter(context = nil)
    @presenter ||= "#{self.class.name}Presenter".constantize.new(self, context)
  end

end