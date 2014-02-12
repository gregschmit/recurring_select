#!/usr/bin/env rake
require 'rubygems'
require 'bundler/setup'

require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec)
task :default => :spec

require 'rubygems/package_task'
Bundler::GemHelper.install_tasks

require 'rdoc/task'
RDoc::Task.new(:rdoc) do |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = 'RecurringSelect'
  rdoc.options << '--line-numbers'
  rdoc.rdoc_files.include('README.rdoc')
  rdoc.rdoc_files.include('lib/**/*.rb')
end

APP_RAKEFILE = File.expand_path("../spec/dummy/Rakefile", __FILE__)
load 'rails/tasks/engine.rake'

