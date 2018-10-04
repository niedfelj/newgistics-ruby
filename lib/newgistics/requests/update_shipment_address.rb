module Newgistics
  module Requests
    class UpdateShipmentAddress
      attr_reader :shipment_address, :response_handler

      def initialize(shipment_address, response_handler: nil)
        @shipment_address = shipment_address
        @response_handler = response_handler || default_response_handler
      end

      def path
        '/update_shipment_address.aspx'
      end

      def body
        xml_builder.to_xml
      end

      def perform
        Newgistics.api.post(self, response_handler)
      end

      private

      def default_response_handler
        ResponseHandlers::UpdateShipmentAddress.new(shipment_address)
      end

      def xml_builder
        Nokogiri::XML::Builder.new do |xml|
          shipment_address_xml(xml)
        end
      end

      def shipment_address_xml(xml)
        xml.updateShipment(apiKey: api_key, orderID: shipment_address.order_id) do
          address_xml(xml)
        end
      end

      def api_key
        Newgistics.configuration.api_key
      end

      def address_xml(xml)
        xml.Company shipment_address.company
        xml.FirstName shipment_address.first_name
        xml.LastName shipment_address.last_name
        xml.Address1 shipment_address.address1
        xml.Address2 shipment_address.address2
        xml.City shipment_address.city
        xml.State shipment_address.state
        xml.Zip shipment_address.zip
        xml.Country shipment_address.country
        xml.Email shipment_address.email
        xml.Phone shipment_address.phone
        xml.IsResidential shipment_address.is_residential
      end
    end
  end
end
