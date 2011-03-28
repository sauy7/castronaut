module Castronaut

  module Presenters

    class Login < Base

      def represent!
        ticket_granting_ticket_result = Castronaut::Models::TicketGrantingTicket.validate_cookie(ticket_generating_ticket_cookie)

        if ticket_granting_ticket_result.valid?
          messages << "You are currently logged in as #{ticket_granting_ticket_result.username}.  If this is not you, please log in below."
        end

        if redirection_loop?
          messages << "The client and server are unable to negotiate authentication.  Please try logging in again later."
        else

          if service
            if !renewal && ticket_granting_ticket_result.valid?
              service_ticket = Castronaut::Models::ServiceTicket.generate_ticket_for(service, client_host, ticket_granting_ticket_result.ticket)
          
              if service_ticket.service_uri
                return controller.redirect(service_ticket.service_uri, 303)
              else
                messages << "The target service your browser supplied appears to be invalid. Please contact your system administrator for help."
              end            
            end
          elsif gateway?
            messages << "The server cannot fulfill this gateway request because no service parameter was given."
          end
        
        end
      
        render :login
              
        self
      end
    
    end

  end
  
end
