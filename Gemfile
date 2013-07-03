source "http://rubygems.org"

# Declare your gem's dependencies in recurring_select.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "rails", "3.2"
gem "jquery-rails"
gem "pg"
gem "ice_cube"

group :development do
  gem "pry"
end

group :test do
  gem "rspec-rails", "2.13.0"
  gem "guard"
  gem "guard-rspec"
  gem 'rb-fsevent', :require => false
end

group :assets do
  gem "sass-rails"
  gem "coffee-rails"
  gem "uglifier"
end
