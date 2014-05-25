require 'rubygems'
require 'spork'

# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
Spork.prefork do
  # Loading more in this block will cause your tests to run faster. However,
  # if you change any configuration or code from libraries loaded here, you'll
  # need to restart spork for it take effect.
  # This file is copied to spec/ when you run 'rails generate rspec:install'
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'webmock/rspec'

  RSpec.configure do |config|
    config.mock_with :rspec
    # If true, the base class of anonymous controllers will be inferred
    # automatically. This will be the default behavior in future versions of
    # rspec-rails.
    config.infer_base_class_for_anonymous_controllers = false
    config.order = "random"

    # Provide view context for Presenter specs
    config.include ActiveSupport::Testing::SetupAndTeardown, :example_group => {:file_path => %r{spec/presenters}}
    config.include ActionView::TestCase::Behavior, :example_group => {:file_path => %r{spec/presenters}}
    config.before(:each, example_group: {:file_path => %r{spec/presenters}}) do
      setup_with_controller  # this is necessary because otherwise @controller is nil, but why?
    end

    # Clean out DB between each run
    config.before :each do
      Mongoid.purge!
    end
  end

  include Devise::TestHelpers
  include Warden::Test::Helpers
  include FactoryGirl::Syntax::Methods

  OmniAuth.config.test_mode = true
  Warden.test_mode!

end

# The Spork.each_run block is run each time you run your specs.  In case you
# need to load files that tend to change during development, require them here.
# With Rails, your application modules are loaded automatically, so sometimes
# this block can remain empty.
Spork.each_run do

  if Spork.using_spork?
    # Reload all app files
    ActionDispatch::Reloader.cleanup!
    ActionDispatch::Reloader.prepare!

    # Requires supporting ruby files with custom matchers and macros, etc,
    # in spec/support/ and its subdirectories.
    Dir[Rails.root.join("spec/support/**/*.rb")].each {|f| require f}
    Dir[Rails.root.join("spec/support/shared_examples/*.rb")].each {|f| require f}

    include SessionHelpers

    # All factories
    FactoryGirl.reload
  end

  # This code will be run each time you run your specs.
  #Dir[Rails.root.join("spec/support/shared_examples/*.rb")].each {|f| require f}
end

