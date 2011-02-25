require File.expand_path(File.join(File.dirname(__FILE__), 'spec_helper'))

require 'sinatra'
require 'test/unit'
require 'rack/test'

Sinatra::Application.set(
  :environment => :test,
  :run => false,
  :raise_errors => true,
  :logging => false
)

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'app', 'config'))
require File.expand_path(File.join(File.dirname(__FILE__), '..', 'app', 'controllers', 'application'))

include Rack::Test::Methods

def app
  Sinatra::Application.new
end
