module Newgistics
  module ResponseHandlers
    class PostProduct
      attr_reader :product

      def initialize(product)
        @product = product
      end

      def handle(response)
        PostErrors.new(product).handle(response)
        if product.errors.empty?
          handle_successful_response(response)
        end
      end

      private

      def handle_successful_response(response)
        xml = Nokogiri::XML(response.body)
        product.id = xml.css('product').first['id']
      end
    end
  end
end
