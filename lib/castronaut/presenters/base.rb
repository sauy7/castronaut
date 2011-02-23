module Castronaut

  module Presenters

    class Base

      MissingCredentialsMessage = "Please supply a username and password to login."

      attr_reader :controller, :html_response
      attr_accessor :messages

      delegate :params, :request, :to => :controller
      delegate :cookies, :env, :to => :request

      def initialize(controller)
        @controller = controller
        @messages = []
        @html_response = nil
      end

      def url
        params['url']
      end

      def ticket_granting_ticket_cookie
        cookies['tgt']
      end

      alias ticket_generating_ticket_cookie ticket_granting_ticket_cookie 

      def client_host
        env['HTTP_X_FORWARDED_FOR'] || env['REMOTE_HOST'] || env['REMOTE_ADDR']
      end

      def login_ticket
        Castronaut::Models::LoginTicket.generate_from(client_host).ticket
      end

      def ticket
        params['ticket']
      end

      def proxy_granting_ticket_url
        params['pgtUrl']
      end

      def service
        params['service']
      end

      def renewal
        params['renew']
      end

      def username
        params['username'].to_s.strip
      end

      def password
        params['password'].to_s.strip
      end

      def gateway?
        %w(true 1).include? params['gateway']
      end

      def redirection_loop?
        params.has_key?('redirection_loop_intercepted')
      end

    protected

      def render template, options = {}
        @html_response = lambda { controller.erb template, {:locals => {:presenter => self}}.merge(options) }
      end

      def redirect uri, code = 303
        @html_response = lambda { controller.redirect uri, code }
      end

      def setup_http_request(url, auth_status, payload)
        request = Net::HTTP::Post.new(url.path, { 'port' => url.port.to_s })
        request.set_form_data('cas_json_payload' => {'cas_status' => auth_status, 'cas_details' => payload}.to_json)
        request
      end

      def setup_http_session(url)
        session = Net::HTTP.new(url.host, url.port.to_s)
        session.use_ssl = true if url.scheme == 'https'
        session
      end

    end

  end

end
