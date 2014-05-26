# A creative interpretation of the Presenter Pattern.
# @abstract
#   Subclasses should be named according to the model they pressent.
#   _Example: `Foo -> FooPresenter`_
class Presenter

  # The model to present
  attr_accessor :object
  # the view context which we call helper methods from
  attr_accessor :context

  # @return (String) underscored version of model class name suitible for a variable name
  def model_name
    @object.class.name.demodulize.underscore
  end

  # @return (String) The singular name of this resource
  def resource_name
    @object.class.name.demodulize.humanize.downcase
  end

  # @param obj mixed
  # @param context the view context
  def initialize(obj, context = nil)
    @object = obj
    mn = model_name
    @context = context
    # create variable with the same name as model class underscored
    self.instance_variable_set("@#{mn}", obj)
    #  create accessor for that attribute
    singleton_class.class_eval do
      attr_accessor mn.to_sym
    end
  end

  # Create path to model resource
  # @see http://apidock.com/rails/ActionController/Base/url_for
  # @param opts (Hash) options passed to url_for
  # @return (String) path to the model resource
  def path opts = {}
    context.url_for(opts)
  end

  # @param opts (Hash)
  # @return (String) link to resource
  def link(opts = {})

    opts.merge!(
        data: {}
    )

    case (opts[:action])
      when :edit
        opts[:text] ||= "Edit"
      when :destroy
        opts[:text] ||= "Delete this #{resource_name}"
        opts[:data].merge!( confirm:  "Are you sure you want to destroy this #{resource_name}?" )
        opts[:method] ||= :delete
      when :new
        opts[:text] ||= "Create a new #{resource_name}"

      else
        opts[:text] ||= self.to_s
    end
    @context.link_to(
        opts.delete(:text),
        path(opts.slice(:action, :controller)),
        opts.except(:action, :controller)
    )
  end

  # Convience method to create anchor element with the class "button"
  # @param opts (Hash)
  # @return (String) anchor element with the class "button"
  def button(opts = {})
    opts[:class] << ' button' if opts[:class]
    opts[:class] ||= 'button'
    opts[:class] << ' alert' if opts[:action] == :destroy
    link(opts)
  end

end