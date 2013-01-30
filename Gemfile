source 'https://rubygems.org'

gem "rails", git: "git://github.com/rails/rails.git", branch: "3-2-stable"
gem 'bcrypt-ruby', '3.0.1'
gem 'haml-rails', '0.3.5'
gem 'jquery-rails', '2.1.4'
gem 'faker', '1.1.2'
gem 'launchy', '2.1.2'
gem 'carrierwave', '0.8.0'

group :development do
  gem 'sqlite3', '1.3.7'
  gem 'brakeman', '1.9.0'
  gem 'annotate', '2.5.0'
  gem 'nifty-generators', '0.4.6'
end

group :test do
  gem 'rspec-rails', '2.12.2'
  gem 'guard-rspec', '2.4.0'
  gem 'capybara', '2.0.2'
  gem 'rb-inotify', '~> 0.8.8'
  gem 'guard-spork', '1.4.1'
  gem 'spork', '0.9.2'
  gem 'factory_girl_rails', '4.1.0'
  gem 'test-unit', '2.5.3'
  gem 'ruby-prof', '0.12.0'
  gem 'database_cleaner', '0.9.1'
  gem 'mocha', '0.13.1', require: false
  gem "simplecov", "~> 0.7.1", require: false
end

group :production do
  gem 'pg', '0.14.1'
end

group :assets do
  gem 'sass-rails', '3.2.6'
  gem 'coffee-rails', '3.2.2'
  gem 'haml', '3.1.7'
  gem 'uglifier', '1.3.0'
end
