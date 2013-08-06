$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "recurring_select/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "recurring_select"
  s.version     = RecurringSelect::VERSION
  s.authors     = ["Jobber", "Forrest Zeisler", "Nathan Youngman"]
  s.email       = ["forrest@getjobber.com"]
  s.homepage    = "http://github.com/getjobber/recurring_select"
  s.summary     = "A select helper which gives you magical powers to generate ice_cube rules."
  s.description = "This gem provides a useful interface for creating recurring rules for the ice_cube gem."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.add_dependency "rails", ">= 3.1"
  s.add_dependency "jquery-rails"
  s.add_dependency "jquery-ui-rails"
  s.add_dependency "ice_cube", ">= 0.8"
  s.add_dependency "sass-rails", ">= 3.1"
  s.add_dependency "coffee-rails", ">= 3.1"

  s.add_development_dependency "appraisal"
  s.add_development_dependency "rspec", "2.13.0"
end
