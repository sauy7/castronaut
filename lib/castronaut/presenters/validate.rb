module Castronaut

  module Presenters

    module Validate

      def self.included(base)

        base.class_eval do
          attr_reader :extra_attributes
          attr_accessor :login_ticket

          def initialize(controller, format)
            super controller, format
            @extra_attributes = Castronaut::ExtraAttributes.new
          end

          def proxy_granting_ticket_iou
            @proxy_granting_ticket_result && @proxy_granting_ticket_result.iou
          end
        end

      end

    end

  end

end
