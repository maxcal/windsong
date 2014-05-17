class Presenter

  attr_accessor :object
  attr_accessor :context

  # @param obj mixed
  # @param context the view context
  def initialize(obj, context = nil)
    model_name = obj.class.name.demodulize.underscore
    @object = obj
    @context = context
    # create variable with the same name as model class underscored
    self.instance_variable_set("@#{model_name}", obj)
    #  create accessor for that attribute
    singleton_class.class_eval do
      attr_accessor model_name.to_sym
    end
  end
end