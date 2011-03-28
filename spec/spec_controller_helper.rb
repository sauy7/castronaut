require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

require 'sinatra'
require 'test/unit'
require 'rack/test'

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'app', 'application'))

Castronaut::Application.set(
  :environment => :test,
  :run => false,
  :raise_errors => true,
  :logging => false
)

include Rack::Test::Methods

def app
  Castronaut::Application.new
end
