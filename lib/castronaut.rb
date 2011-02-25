%w(
  configuration
  support/sample
  utilities/random_string
  models/consumeable
  models/dispenser
  models/login_ticket
  models/service_ticket
  models/proxy_ticket
  models/ticket_granting_ticket
  models/proxy_granting_ticket
  authentication_result
  extra_attributes
  ticket_result
  presenters/base
  presenters/validate
  presenters/login
  presenters/logout
  presenters/process_login
  presenters/service_validate
  presenters/proxy_validate
  adapters
).each do |file|

  require File.expand_path( File.join File.dirname(__FILE__), 'castronaut', file )

end

module Castronaut

  def self.config
    @cas_config
  end

  def self.config=(config)
    @cas_config = config
  end

  def self.logger
    @cas_config.logger
  end

end
