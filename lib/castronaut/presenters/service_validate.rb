module Castronaut

  module Presenters

    class ServiceValidate < Base

      include Validate

      attr_reader :service_ticket_result

      def represent!
        @service_ticket_result = Castronaut::Models::ServiceTicket.validate_ticket(service, ticket)

        if @service_ticket_result.valid?
          if proxy_granting_ticket_url
            @proxy_granting_ticket_result = Castronaut::Models::ProxyGrantingTicket.generate_ticket(proxy_granting_ticket_url, client_host, @service_ticket_result.ticket)
          end
        end

        render :service_validate

        self
      end

      def username
        @service_ticket_result.username
      end

    end

  end

end
