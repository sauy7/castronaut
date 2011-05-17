require 'sinatra'
require 'castronaut'

# support the Sinatra 1.2 "url" helper for Sinatra 1.0
module Sinatra
  module Helpers
    unless respond_to? :uri
      # Generates the absolute URI for a given path in the app.
      # Takes Rack routers and reverse proxies into account.
      def uri(addr = nil, absolute = true, add_script_name = true)
        return addr if addr =~ /\A[A-z][A-z0-9\+\.\-]*:/
        uri = [host = ""]
        if absolute
          host << "http#{'s' if request.secure?}://"
          if request.env.include? "HTTP_X_FORWARDED_HOST" or request.port != (request.secure? ? 443 : 80)
            host << "#{request.host}:#{request.port}"
          else
            host << request.host
          end
        end
        uri << request.script_name.to_s if add_script_name
        uri << (addr ? addr : request.path_info).to_s
        File.join uri
      end

      alias url uri
      alias to uri
    end
  end
end

module Castronaut

  class Application < Sinatra::Base

    configure do

      root     = File.expand_path( '../../../app', __FILE__ )
      app_file = "#{root}/controllers/application.rb"
      views    = "#{root}/views"
      pub_dir  = "#{root}/public"

      Castronaut.logger.debug "Sinatra Config - setting root path to #{root}"
      Castronaut.logger.debug "Sinatra Config - setting views path to #{views}"
      Castronaut.logger.debug "Sinatra Config - setting public path to #{pub_dir}"

      set :environment,  Castronaut.config.environment.to_sym
      set :run,          true
      set :raise_errors, true
      set :logging,      true
      set :port,         Castronaut.config.respond_to?(:server_port) ? Castronaut.config.server_port : Sinatra::Application.default_options[:port]

      set :root,         root
      set :app_file,     app_file
      set :views,        views
      set :public,       pub_dir
      set :logging,      true
      set :raise_errors, true
      set :run,          false
      set :env,          ENV['RACK_ENV'] || 'production'

    end

  private

    def self.path_regex path
      /^\/#{path}(\.json)?$/
    end

  public

    get '/' do
      redirect '/login'
    end

    get(path_regex 'login') do |extension|
      no_cache
      present! Presenters::Login, view_format(extension)
    end

    post(path_regex 'login') do |extension|
      present! Presenters::ProcessLogin, view_format(extension)
    end

    get(path_regex 'logout') do |extension|
      present! Presenters::Logout, view_format(extension)
    end

    get(path_regex 'serviceValidate') do |extension|
      present! Presenters::ServiceValidate, view_format(extension, :xml)
    end

    get(path_regex 'proxyValidate') do |extension|
      present! Presenters::ProxyValidate, view_format(extension, :xml)
    end

    def view_format(extension, default = :html)
      extension && extension.delete('.').to_sym || default
    end

  private

    def no_cache
      response.headers.merge!(
        'Pragma' => 'no-cache',
        'Cache-Control' => 'no-store',
        'Expires' => (Time.now - 5.years).rfc2822
      )
    end

    def present!(klass, format = :html)
      @presenter = klass.new(self, format)
      @presenter.represent!
      @presenter.your_mission.call
    end

  end # class

end # module
