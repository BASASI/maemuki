source 'https://rubygems.org'

group :default do
  # Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '4.1.5'
  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 4.0.3'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'

  # Use jquery as the JavaScript library
  gem 'jquery-rails'
  # Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
  gem 'turbolinks'
  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 2.0'

  # Use unicorn as the app server
  gem 'unicorn'

  gem 'bootstrap-sass'
  gem 'autoprefixer-rails'
  gem 'font-awesome-rails'
  gem 'carrierwave'
  gem 'chart-js-rails'

  gem 'devise'
  gem 'omniauth'
  gem 'omniauth-facebook'
  gem 'omniauth-twitter'
  gem 'twitter'
  gem 'dotenv-rails'

  gem 'active_model_serializers'
  gem 'resque'
end

group :staging, :production do
  gem 'mysql2'
  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  gem 'therubyracer',  platforms: :ruby
end

group :test, :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
end

group :development do
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-commands-rspec'

  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'

  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spring'

  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'rails_best_practices'
  gem 'bullet'

  gem 'annotate', :git => 'https://github.com/ctran/annotate_models'

  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
end

group :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_rewinder'
  gem 'faker'
  gem 'shoulda-matchers', require: false
  gem 'json_spec'
end

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', '~> 0.4.0'
end

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use debugger
# gem 'debugger', group: [:development, :test]

