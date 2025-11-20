module SpreeEltaCourier
  class PrintVouchers
    include Spree::IntegrationsConcern

    attr_reader :vg_code, :client

    def initialize(vg_code)
      @vg_code = vg_code

      @client = EltaCourier::SoapClient.new(:print)
    end

    def call
      integration = store_integration('elta_courier')

      raise 'Integration not found' unless integration

      preferred_paper_size = integration.preferred_paper_size

      record = {
        'vg_code' => vg_code,
        'paper_size' => preferred_paper_size
      }

      result = client.call(
        :read,
        record
      )

      return result if result[:st_flag].to_i.zero?

      raise VoucherError, "Failed to print voucher: #{result[:st_title]}" if result[:st_flag].to_i != 0
    end
  end
end
