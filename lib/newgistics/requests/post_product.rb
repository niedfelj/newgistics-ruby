module Newgistics
  module Requests
    class PostProduct
      attr_reader :product, :response_handler

      def initialize(product, response_handler: nil)
        @product = product
        @response_handler = response_handler || default_response_handler
      end

      def path
        '/post_products.aspx'
      end

      def body
        xml_builder.to_xml
      end

      def perform
        Newgistics.api.post(self, response_handler)
      end

      private

      def default_response_handler
        ResponseHandlers::PostProduct.new(product)
      end

      def xml_builder
        Nokogiri::XML::Builder.new do |xml|
          products_xml(xml)
        end
      end

      def products_xml(xml)
        xml.products(apiKey: api_key) do
          product_xml(product, xml)
        end
      end

      def api_key
        Newgistics.configuration.api_key
      end

      def product_xml(product, xml)
        attributes = product.attributes.except(:custom_fields, :errors, :warnings)
        xml.product do
          xml.id product.id
          xml.sku product.sku
          xml.description product.description
          xml.upc product.upc
          xml.supplier product.supplier
          xml.supplierCode product.supplier_code
          xml.category product.category
          xml.height product.height
          xml.width product.width
          xml.depth product.depth
          xml.value product.value
          xml.retailValue product.retail_value
          xml.shipFrom product.ship_from
          if product.country_of_origin
            xml.countryOfOrigin product.country_of_origin
          end 
          xml.manufacture product.manufacture
          xml.isActive product.is_active

          custom_fields_xml(product, xml)

        end
      end

      def custom_fields_xml(object, xml)
        xml.CustomFields do
          object.custom_fields.each do |key, value|
            xml.send StringHelper.camelize(key), value
          end
        end
      end

    end
  end
end
