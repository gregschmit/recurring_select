# Maintain your gem's version:
require_relative "lib/recurring_select/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name = "recurring_select"
  s.version = RecurringSelect::VERSION
  s.authors = ["Jobber", "Forrest Zeisler", "Nathan Youngman", "Gregory Schmit"]
  s.email = ["schmitgreg@gmail.com"]
  s.homepage = "http://github.com/gregschmit/recurring_select"
  s.summary = "A select helper which gives you magical powers to generate ice_cube rules."
  s.description = "This gem provides a useful interface for creating recurring rules for the ice_cube gem."

  s.files = Dir["{app,config,db,lib}/**/*"] + ["MIT-LICENSE", "Rakefile", "README.md"]
  s.test_files = Dir["test/**/*"]

  s.required_ruby_version = ">= 3.3.7"
  
  s.add_dependency "rails", ">= 7.2"
  s.add_dependency "ice_cube", ">= 0.11"
  s.add_dependency "sassc-rails", ">= 2.1"

  s.add_development_dependency "bundler", ">= 2.0"
  s.add_development_dependency "rspec-rails", ">= 7.0"
  s.add_development_dependency "rspec", ">= 3.0"
  s.add_development_dependency "rake", ">= 13.0"

  s.license = 'MIT'
end
