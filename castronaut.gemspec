# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'castronaut/version'

Gem::Specification.new do |gem|
  gem.name          = "castronaut"
  gem.version       = Castronaut::VERSION
  gem.authors = ["Relevance, Inc."]
  gem.email         = ["nbudin@patientslikeme.com"]
  gem.description   = %q{Your friendly, cigar smoking authentication dicator... From Space!}
  gem.summary       = %q{A simple, embeddable CAS server}

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.default_executable = %q{castronaut}

  gem.add_dependency 'sinatra'
  gem.add_dependency 'json'
  gem.add_dependency 'builder', '>= 2.0.0'
end

