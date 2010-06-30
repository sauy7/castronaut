module Castronaut
  module Adapters
    
    def self.selected_adapter
      case Castronaut.config.cas_adapter['adapter']
        when "development"
          require File.expand_path(__FILE__, 'adapters' 'development', 'adapter')
          require File.expand_path(__FILE__, 'adapters' 'development', 'user')
          Castronaut::Adapters::Development::Adapter
        when "ldap"
          require File.expand_path(__FILE__, 'adapters' 'ldap', 'adapter')
          require File.expand_path(__FILE__, 'adapters' 'ldap', 'user')
          Castronaut::Adapters::Ldap::Adapter
        when "database"
          require File.expand_path(__FILE__, 'adapters' 'restful_authentication', 'adapter')
          require File.expand_path(__FILE__, 'adapters' 'restful_authentication', 'user')
          Castronaut::Adapters::RestfulAuthentication::Adapter
      end
    end
    
  end
end
