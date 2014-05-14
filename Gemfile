source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.3'

# ===== FRONTEND  ========================================================================
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# ZURB Foundation on Sass/Compass (http://foundation.zurb.com/)
gem 'foundation-rails', '~> 5.2.2.0'

# ===== Views  ===========================================================================
# Forms made easy for Rails! It's tied to a simple DSL, with no opinion on markup.
gem 'simple_form', '~> 3.0.2'

# ===== API  =============================================================================
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# ===== DB ===============================================================================
# Ruby Object Mapper for Mongo
gem 'mongoid', '4.0.0.beta1', github: 'mongoid/mongoid'
#C extensions to accelerate the Ruby BSON serialization.
gem 'bson_ext'
# Mongoid URL slug or permalink generator
gem 'mongoid_slug', '~> 3.2.1'

# ===== AAA ==============================================================================
gem 'devise', '~> 3.2.4'
# A generalized Rack framework for multiple-provider authentication.
gem 'omniauth', '~> 1.2.1'

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer',  platforms: :ruby
  # Provides a better error page for Rails and other Rack apps.
  gem 'better_errors', '~> 1.1.0'
  # Page loading speed displayed on every page.
  gem 'miniprofiler', '~> 0.1.7.4', require: false
  # Sends meta headers for RailsPanel in google chrome
  gem 'meta_request', require: false
  # Annotate models
  gem 'annotate', require: false
end

group :development, :test do
  #Loads environment variables from .env file
  gem 'dotenv-rails', '~> 0.10.0'
  # BDD for Ruby
  gem "rspec-rails" #, "~> 2.14.1"
  # A forking Drb spec server
  gem "spork-rails", "~> 4.0.0", require: false
  # Guard is a command line tool to easily handle events on file system modifications.
  gem "guard-spork", "~> 1.5.1", require: false
  gem "guard-rspec", "~> 4.2.8", require: false
  # Show test status indicators on Mac OS X
  gem "terminal-notifier-guard", "~> 1.5.3", require: false
end

group :test do
  # Fixes annoying rspec bug "Warning: you should require 'minitest/autorun' instead."
  gem "minitest"
  # WebMock allows stubbing HTTP requests and setting expectations on HTTP requests.
  gem 'webmock', '~> 1.17.4'
  # Capybara is an integration testing tool for rack based web applications.
  gem 'capybara', '~> 2.2.1'
  # factory_girl provides a framework and DSL for defining and using factories.
  gem "factory_girl_rails", "~> 4.4.1"
  # Matchers to make model specs easy on the fingers and eyes
  gem "shoulda-matchers", "~> 2.5.0"
end