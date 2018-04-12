source 'https://rubygems.org'

ruby '2.5.1'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end

# Framework
gem 'rails', '~> 5.2'

# Webserver
gem 'puma'

# Data
gem 'pg'
gem 'faker'
gem 'seedbank'   # seed data organization

# Frontend
gem 'bootstrap', '~> 4.0.0'
gem 'jquery-rails'
gem 'sass-rails', '~> 5.0'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'

# User Authentication
gem 'bcrypt', '~> 3.1.7'
gem 'devise', github: 'plataformatec/devise' #, ref: '88e9a85'

# Background Processing
gem 'sidekiq'
gem 'sidekiq-scheduler'

# Misc
gem 'dotiw'        # Better distance of time in words for Rails
gem 'sentry-raven' # logging
gem 'colorize'     # colored strings are nice for debugging
gem 'fast_blank'   # a booster for .blank?/.present? calls
gem 'awesome_print' # print anything in the console

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_bot_rails'

  gem 'capybara', '~> 2.13'
  gem 'selenium-webdriver'
end

group :development do
  gem "better_errors" # Better error page for Rack apps
  gem "binding_of_caller"

  gem 'hirb', github: 'bsharpe/hirb', branch: :master # nice record display in console
  gem 'annotate', github: 'ctran/annotate_models', branch: :develop # Annotate models on migration
  gem 'bundleup', require: false # know which gems need updating
  gem 'rubocop', require: false # style cop
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data' #, platforms: [:mingw, :mswin, :x64_mingw, :jruby]
