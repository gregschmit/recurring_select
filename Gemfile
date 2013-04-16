source "http://rubygems.org"

# Declare your gem's dependencies in recurring_select.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# jquery-rails is used by the dummy application
gem "jquery-rails"
gem "pg"
gem "pry"
gem "ice_cube"

group :test do
  gem "database_cleaner"
  gem "rspec"
  #gem "mocha", :require => false

  gem "spork", "~> 0.9.2"
  gem "guard", "1.7.0"
  gem "guard-spork"
  gem "guard-rspec", "~> 2.5.3"
  gem "guard-jasmine"

  gem 'rb-fsevent', :require => false
end

