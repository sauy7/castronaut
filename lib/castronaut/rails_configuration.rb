module Castronaut
  # To be used instead of Castronaut::Configuration when Castronaut is embedded into
  # a Rails application.  This class hooks Castronaut's environment, log, database,
  # etc. into Rails' configuration.  
  class RailsConfiguration < Castronaut::Configuration    
    attr_accessor :organization_name
    
    def initialize
      self.logger = Rails.logger
      
      parse_config_into_settings({
        'environment' => Rails.env
      })
    end
    
    def server_port
      nil
    end
  end
end