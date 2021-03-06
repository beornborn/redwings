source 'https://rubygems.org'

ruby '2.3.0'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.1'


# Pg is the Ruby interface to the PostgreSQL. Read more: https://github.com/ged/ruby-pg
gem 'pg'


# Magical Authentication for Rails 3 and 4. Read more: https://github.com/NoamB/sorcery
gem 'sorcery'

gem 'zeroclipboard-rails'
gem 'letter_opener', group: :development
gem 'addressable'
gem 'rest-client', '~> 1.8.0'
gem 'slack-api', '1.1.6', require: 'slack'

# Twitter Bootstrap 3.2 for Rails 4 Asset Pipeline
gem 'twitter-bootstrap-rails', :git => 'git://github.com/seyhunak/twitter-bootstrap-rails.git'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Slim is a fast, lightweight templating engine with support for Rails 3 and 4 Read more: https://github.com/slim-template/slim
gem 'slim', '~> 3.0.6'
# Settingslogic is a simple configuration / settings solution. Read more: https://github.com/settingslogic/settingslogic
gem 'settingslogic'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use to restrict what resources a given user is allowed to access
gem 'cancancan', '~> 1.10'

# Kaminari paginator. Read more: https://github.com/amatsuda/kaminari
gem 'kaminari'

# dotiw is a gem for Rails that overrides the default distance_of_time_in_words. Read more: https://github.com/radar/dotiw
gem 'dotiw'

# Efficient background processing for Ruby,uses threads to handle many jobs at the same time in the same process
gem 'sidekiq'
# Sinatra is a DSL for quickly creating web applications in Ruby with minimal effort
# Need for sidekiq web ui
gem 'sinatra', require: false
# A Ruby client that tries to match Redis' API one-to-one
gem 'redis'
# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  gem 'pry-rails'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'

  # Awesome Print is a Ruby library that pretty prints Ruby objects in full color exposing their internal structure with proper indentation. Read more: https://github.com/michaeldv/awesome_print
  gem 'awesome_print'

  # Rspec-rails is a testing framework for Rails 4.x. Read more: https://github.com/rspec/rspec-rails
  gem 'rspec-rails', '3.3.2'
end

group :production do
  # Makes running your Rails app easier. For Heroku.
  gem 'rails_12factor'

  # Puma is a simple, fast, threaded, and highly concurrent HTTP 1.1 server for Ruby/Rack applications. Read more: https://github.com/puma/puma
  gem 'puma'

  # Clockwork - a clock process to replace cron. Read more: https://github.com/tomykaira/clockwork
  gem 'clockwork'
end

