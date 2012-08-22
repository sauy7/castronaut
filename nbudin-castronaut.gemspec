# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'castronaut/version'

Gem::Specification.new do |gem|
  gem.name          = "nbudin-castronaut"
  gem.version       = Castronaut::NBUDIN_VERSION
  gem.authors = ["Relevance, Inc.", "Nat Budin"]
  gem.email         = ["nbudin@patientslikeme.com"]
  gem.description   = %q{Nat Budin's experimental fork of Castronaut}
  gem.summary       = %q{A simple, embeddable CAS server}

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.default_executable = %q{castronaut}

  gem.add_dependency 'sinatra'
  gem.add_dependency 'multi_json'
  gem.add_dependency 'builder', '>= 2.0.0'
  gem.add_dependency 'rake'

  gem.add_development_dependency 'rspec'
end
