# -*- encoding: utf-8 -*-
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'rack/gcm'

Gem::Specification.new do |s|
  s.name        = "rack-gcm"
  s.authors     = ["Min Kim"]
  s.email       = ["minsikzzang@gmail.com", "minsik.kim@livestation.com"]
  s.homepage    = "http://github.com/minsikzzang/sanjose"
  s.version     = Rack::GCM::VERSION
  s.platform    = Gem::Platform::RUBY
  s.summary     = "REST API Rack for Google cloud message token registration"
  s.description = "Generate a REST API for registering and querying Google cloud message device tokens."

  s.add_dependency "rack", "~> 1.4"
  s.add_dependency "rack-contrib", "~> 1.1"
  s.add_dependency "sequel", "~> 3.37"
  s.add_dependency "sinatra", "~> 1.3"
  s.add_dependency "sinatra-param", "~> 0.1"

  s.add_development_dependency "rspec"
  s.add_development_dependency "rake"

  s.files         = Dir["./**/*"].reject { |file| file =~ /\.\/(bin|example|log|pkg|script|spec|test|vendor)/ }
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
