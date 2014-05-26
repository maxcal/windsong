# Methods for models to handle presenter instances
module Presentable
  # Memoized getter that creates a presenter for model
  # @param context the view context
  # @return (Presenter)
  def presenter(context = nil)
    @presenter ||= "#{self.class.name}Presenter".constantize.new(self, context)
  end
end