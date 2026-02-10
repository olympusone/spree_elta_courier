module Spree
  module ShipmentDecorator
    def can_create_elta_courier_voucher?
      !tracked? && ready? && shipping_method.elta_courier?
    end

    def can_print_elta_courier_voucher?
      tracked? && shipping_method.elta_courier?
    end
  end

  Shipment.prepend ShipmentDecorator
end
