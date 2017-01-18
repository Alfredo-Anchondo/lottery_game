source 'http://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2'
# Use sqlite3 as the database for Active Record
gem 'pg', '0.18.4'
#gem 'pg', '~> 0.19.0.pre20160409114042'
gem "foreigner"
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer',  platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
 gem 'unicorn', group: :production

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
#gem 'tzinfo-data', platforms: [:mingw, :mswin]
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw]
gem "devise"
gem 'money-rails'
gem "cancan"
gem "will_paginate"
gem "paperclip", "~> 4.2"
gem 'active_model_serializers'
gem 'omniauth-facebook'
gem 'omniauth-twitter'
gem 'openpay'
gem 'whenever'
gem 'rack-cors', :require => 'rack/cors'
gem 'validates_overlap'
gem 'rails_best_practices', group: :development
gem 'serviceworker-rails'
gem 'delayed_job_active_record'
gem 'devise_token_auth'
#gem "ultrahook", group: :development

group :development, :test do
  gem 'byebug'
  gem 'rspec-rails', '~> 3.5'
  gem 'factory_girl_rails', '~> 4.5'
  gem 'capybara', '~> 2.5'
end


group :test do
  gem 'shoulda-matchers', '~> 3.0', require: false
  gem 'database_cleaner', '~> 1.5'
  gem 'faker', '~> 1.6.1'
end
