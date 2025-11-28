module Spree
  module OrderDecorator
    def can_create_voucher?
      shipments.any?(&:can_create_voucher?)
    end

    def can_print_voucher?
      shipments.any?(&:can_print_voucher?)
    end
  end

  Order.prepend OrderDecorator
end
