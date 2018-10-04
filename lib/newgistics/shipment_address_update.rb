module Newgistics
  class ShipmentAddressUpdate
    include Newgistics::Model

    attribute :id, String # shipment id
    attribute :order_id, String

    attribute :customer, Customer

    attribute :status, String
    attribute :status_notes, String
    attribute :ship_method, String

    attribute :success, Boolean

    attribute :errors, Array[String], default: []
    attribute :warnings, Array[String], default: []

    def success?
      !!success
    end

    def save
      Requests::UpdateShipmentAddress.new(self).perform

      errors.empty? && success?
    end
  end
end
