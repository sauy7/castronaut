require 'rubygems'
require 'bundler/setup'
require 'sinatra'

require File.expand_path(File.join(File.dirname(__FILE__), '..', 'castronaut'))

default_config = File.expand_path("../config/castronaut.yml")

if File.exist?(default_config)
  Castronaut.config = Castronaut::Configuration.load(default_config)
else
  STDERR.puts "Unable to locate configuration.  Currently looking at #{default_config}."
end

require "application"

run Castronaut::Application
