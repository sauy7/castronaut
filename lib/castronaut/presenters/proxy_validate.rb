module Castronaut

  module Presenters

    class ProxyValidate < Base

      include Validate

      attr_reader :proxy_ticket_result, :proxies
      attr_accessor :login_ticket

      def represent!
        @proxy_ticket_result = Castronaut::Models::ProxyTicket.validate_ticket(service, ticket)

        if @proxy_ticket_result.valid?
          @proxies = @proxy_ticket_result.proxies

          if proxy_granting_ticket_url
            @proxy_granting_ticket_result = Castronaut::Models::ProxyGrantingTicket.generate_ticket(proxy_granting_ticket_url, client_host, @proxy_ticket_result.ticket)
          end
        end

        render :proxy_validate

        self
      end

      def username
        @proxy_ticket_result.username
      end

    end

  end

end
