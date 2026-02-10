module Spree
  module OrderDecorator
    def can_create_elta_courier_voucher?
      shipments.any?(&:can_create_elta_courier_voucher?)
    end

    def can_print_elta_courier_voucher?
      shipments.any?(&:can_print_elta_courier_voucher?)
    end
  end

  Order.prepend OrderDecorator
end
