$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "recurring_select/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "recurring_select"
  s.version     = RecurringSelect::VERSION
  s.authors     = ["Forrest Zeisler"]
  s.email       = ["development@forrestzeisler.com"]
  s.homepage    = "http://github.com/forrest/recurring_select"
  s.summary     = "This is a gem to add a number of selectors and helpers for working with recurring schedules in a rails app."
  s.description = "This is a gem to add a number of selectors and helpers for working with recurring schedules in a rails app."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.rdoc"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", "~> 3.1.1"
  s.add_dependency "jquery-rails"
  s.add_dependency "ice_cube", "~> 0.6"
  s.add_dependency "sass-rails", "~> 3.1.5"
  s.add_dependency "coffee-rails", "~> 3.1.1"
  
  s.add_development_dependency "pry"
end
