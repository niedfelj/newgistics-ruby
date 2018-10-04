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
          address_xml(shipment_address.customer, xml)
        end
      end

      def api_key
        Newgistics.configuration.api_key
      end

      def address_xml(customer, xml)
        xml.Company customer.company
        xml.FirstName customer.first_name
        xml.LastName customer.last_name
        xml.Address1 customer.address1
        xml.Address2 customer.address2
        xml.City customer.city
        xml.State customer.state
        xml.Zip customer.zip
        xml.Country customer.country
        xml.Email customer.email
        xml.Phone customer.phone
        xml.IsResidential customer.is_residential
      end
    end
  end
end
