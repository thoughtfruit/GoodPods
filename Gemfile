source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# ruby '2.5.3'

gem 'rails', '6.0.2.1'

group :production do
  gem 'pg'
end

gem 'mini_racer'
gem 'material_icons'
gem 'awesome_print'
gem 'fastercsv' # Only required on Ruby 1.8 and below
gem 'rails_admin'
gem 'puma', '~> 3.11'
gem 'loofah'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.2'
gem 'jbuilder', '~> 2.5'
gem 'bootsnap', '>= 1.1.0', require: false
gem 'responders'
gem 'jquery'
gem 'rails-bootstrap'
gem 'bootstrap'
gem 'jquery-rails'
gem "rack-cors", ">= 0.4.1"
gem 'devise'
gem 'faraday'
gem 'pry'
gem 'honeybadger', '~> 4.0'
gem 'nokogiri'
gem 'httparty'
gem 'audiojs-rails'

group :development, :test do
  gem 'sqlite3'
  gem 'rspec-rails'
  gem 'rb-readline'
  gem 'binding_of_caller'
  gem 'spring-commands-rspec'
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
end

gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
