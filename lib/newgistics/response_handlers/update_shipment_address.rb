module Newgistics
  module ResponseHandlers
    class UpdateShipmentAddress
      attr_reader :shipment_address

      def initialize(shipment_address)
        @shipment_address = shipment_address
      end

      def handle(response)
        PostErrors.new(shipment_address).handle(response)
        if shipment_address.errors.empty?
          handle_successful_response(response)
        end
      end

      private

      def handle_successful_response(response)
        xml = Nokogiri::XML(response.body)
        shipment_address.success = xml.at_css('success').text
      end
    end
  end
end
