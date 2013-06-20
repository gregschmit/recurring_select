source "http://rubygems.org"

# Declare your gem's dependencies in recurring_select.gemspec.
# Bundler will treat runtime dependencies like base dependencies, and
# development dependencies will be added by default to the :development group.
gemspec

# support multiple rails versions
# http://schneems.com/post/50991826838/testing-against-multiple-rails-versions
rails_version = ENV["RAILS_VERSION"] || "default"

rails = case rails_version
when "master"
  {github: "rails/rails"}
when "default"
  ">= 3.1.0"
else
  "~> #{rails_version}"
end
gem "rails", rails

sass_version = ENV["SASS_VERSION"] || ">= 3.1"

# jquery-rails is used by the dummy application
gem "jquery-rails"
gem "pg"
gem "ice_cube"

group :test do
  gem "rspec"
  gem "spork", "~> 0.9.2"
  gem "guard"
  gem "guard-spork"
  gem "guard-rspec"
  # gem "guard-jasmine"

  gem 'rb-fsevent', :require => false
end

group :assets do
  gem "sass-rails", sass_version
  gem "coffee-rails"
  gem "uglifier"
end
