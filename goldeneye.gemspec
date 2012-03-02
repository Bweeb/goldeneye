# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "goldeneye/version"

Gem::Specification.new do |s|
  s.name    = %q{Goldeneye}
  s.version = Goldeneye::VERSION

  s.authors     = ["Fabio Kreusch"]
  s.email       = ["fabiokr@gmail.com"]
  s.homepage    = "http://www.site5.com"
  s.summary     = "Wrapper for the R1Soft CDP API"
  s.description = "Goldeneye allows for easy interaction with the R1Soft CDP API."

  s.rubyforge_project = "goldeneye"
  s.files             = `git ls-files`.split("\n")
  s.test_files        = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables       = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths     = ["lib"]

  s.add_runtime_dependency 'logging', '~> 1.7.0'
  s.add_runtime_dependency 'savon', '~> 0.9.9'
  s.add_runtime_dependency 'xml-simple', '~> 1.1.1'
  s.add_runtime_dependency 'thor', '~> 0.14.6'
  s.add_runtime_dependency 'jruby-openssl' if RUBY_PLATFORM == 'java'

  s.add_development_dependency 'mocha', '~> 0.10.3'
  s.add_development_dependency 'rdoc', '~> 3.12'
  s.add_development_dependency 'rake', '~> 0.9.2.2'
end