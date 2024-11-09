$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "recurring_select/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "recurring_select"
  s.version     = RecurringSelect::VERSION
  s.authors     = ["Jobber", "Forrest Zeisler", "Nathan Youngman", "Tyler Merritt"]
  s.email       = ["tgmerritt@gmail.com"]
  s.homepage    = "http://github.com/getjobber/recurring_select"
  s.summary     = "A select helper which gives you magical powers to generate ice_cube rules."
  s.description = "This gem provides a useful interface for creating recurring rules for the ice_cube gem."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  # Dependencies
  s.add_dependency "rails", "~> 6.1.6"
  s.add_dependency "jquery-rails", ">= 3.0"
  s.add_dependency "ice_cube", ">= 0.11"
  
  # Switch from sassc-rails to dart-sass
  s.add_dependency "sass", "~> 3.7"

  s.add_dependency "coffee-rails", ">= 3.1"

  # Development dependencies
  s.add_development_dependency "bundler", ">= 1.3.5"
  s.add_development_dependency "rspec-rails", ">= 2.14"
  s.add_development_dependency "rspec", ">= 2.14"
  s.add_development_dependency "rake", ">= 0.9.6"

  s.license = 'MIT'
end
