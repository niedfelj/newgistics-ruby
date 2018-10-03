module Newgistics
  class ProductDetail
    include Newgistics::Model

    attribute :id, String
    attribute :sku, String
    attribute :description, String
    attribute :upc, String
    attribute :supplier, String
    attribute :supplier_code, String
    attribute :category, String
    attribute :height, Integer
    attribute :width, Integer
    attribute :depth, Integer
    attribute :value, Float
    attribute :retail_value, Float
    attribute :ship_from, String, default: 'Newgistics'
    attribute :country_of_origin, String
    attribute :manufacture, String
    attribute :is_active, Boolean, default: true
    attribute :custom_fields, Hash

    attribute :errors, Array[String], default: []
    attribute :warnings, Array[String], default: []

    def self.all
      where({}).all
    end

    def self.where(conditions)
      Query.build(
        endpoint: '/products.aspx',
        model_class: self
      ).where(conditions)
    end

    def self.element_selector
      'product'
    end

    def save
      Requests::PostProduct.new(self).perform

      errors.empty?
    end

  end
end


ATTRIBUTES = [:sku,

              :customFields]
