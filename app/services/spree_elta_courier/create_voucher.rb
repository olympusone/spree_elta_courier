module SpreeEltaCourier
  class CreateVoucher
    attr_reader :shipment, :num_packages, :order, :client

    def initialize(shipment, num_packages = 1)
      @shipment = shipment
      @num_packages = num_packages

      @order = shipment.order

      @client = EltaCourier::SoapClient.new(:create)
    end

    def call
      address = shipment.address
      cod_payment = order.payment_method&.cod_payment?

      record = {
        'pel_paral_name' => address.full_name,
        'pel_paral_address' => address.address1,
        'pel_paral_area' => address.city,
        'pel_paral_tk' => address.zipcode.gsub(/\s+/, ''),
        'pel_paral_thl_1' => address.phone,
        'pel_baros' => shipment.item_weight.to_f,
        'pel_temaxia' => num_packages,
        'pel_paral_sxolia' => order.special_instructions,
        'pel_ant_poso' => cod_payment ? shipment.final_price_with_items.to_f : 0,
        'pel_ref_no' => shipment.number,
        'sideta_eidos' => 2 # 1=Documents, 2=Parcel
      }

      result = client.call(
        :read,
        record
      )

      return result if result[:st_flag].to_i.zero?

      raise VoucherError, "Failed to create voucher: #{result[:st_title]}" if result[:st_flag].to_i != 0
    end

    class VoucherError < StandardError; end
  end
end
