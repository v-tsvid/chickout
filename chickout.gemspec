$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chickout/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chickout"
  s.version     = Chickout::VERSION
  s.authors     = ["v-tsvid"]
  s.email       = ["vadim.tsvid@gmail.com"]
  s.homepage    = "http://chickout.com"
  s.summary     = "Summary of Chickout."
  s.description = "Description of Chickout."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.rdoc"]

  s.add_dependency "rails", "~> 4.2.7.1"
  s.add_dependency 'sass-rails', '5.0.3'
  s.add_dependency 'aasm', '4.2.0'
  s.add_dependency 'reform', '2.1.0'
  s.add_dependency 'reform-rails', '0.1.0'
  s.add_dependency 'bootstrap-sass', '3.3.5.1'
  s.add_dependency 'draper', '2.1.0'
  
  s.add_development_dependency 'rspec-rails', '3.4.2'
  s.add_development_dependency 'capybara', '2.4.4'
  s.add_development_dependency 'factory_girl_rails', '4.5.0'
  s.add_development_dependency 'byebug'

  s.add_development_dependency "sqlite3"

  s.test_files = Dir["spec/**/*"]
end
