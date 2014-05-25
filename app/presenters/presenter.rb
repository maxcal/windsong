class Presenter

  attr_accessor :object
  attr_accessor :context

  def model_name
    @object.class.name.demodulize.underscore
  end

  # the singular name of this resource
  # @return String
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
  # @param opts Hash see http://apidock.com/rails/ActionController/Base/url_for
  # @return String the path to the model resource
  def path opts = {}
    context.url_for(opts)
  end

  # create a link to resource
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
        opts[:method] ||= :destroy
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

  def button(opts = {})
    opts[:class] << ' button' if opts[:class]
    opts[:class] ||= 'button'

    opts[:class] << ' alert' if opts[:action] == :destroy


    link(opts)
  end

end