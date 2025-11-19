module Spree
  module ShipmentDecorator
    def can_create_voucher?
      !tracked? && ready?
    end

    def can_print_voucher?
      tracked?
    end
  end
end

Spree::Shipment.prepend Spree::ShipmentDecorator
