require 'combine_pdf'

module Spree
  module Admin
    class EltaCourierController < Spree::Admin::BaseController
      include Spree::Admin::OrdersFiltersHelper

      def create
        begin
          load_order

          @order.shipments.each do |shipment|
            next unless shipment.can_create_voucher?

            result = SpreeEltaCourier::CreateVoucher.new(shipment).call

            shipment.update(
              tracking: result[:vg_code]
            )
          end

          flash[:success] = Spree.t('admin.integrations.elta_courier.voucher_successfully_created')
          redirect_to spree.admin_order_path(@order)
        rescue ActiveRecord::RecordNotFound
          order_not_found
        rescue StandardError => e
          Rails.logger.error "Elta Courier Error: #{e.message}"

          flash[:error] = Spree.t('admin.integrations.elta_courier.voucher_creation_failed')
          redirect_to spree.admin_order_path(@order)
        end
      end

      def print
        begin
          load_order

          voucher_numbers = @order.shipments.select(&:can_print_voucher?)
                                  .map(&:tracking).compact

          if voucher_numbers.empty?
            raise StandardError, Spree.t('admin.integrations.elta_courier.voucher_print_failed')
          end

          decoded_pdfs = voucher_numbers.map do |number|
            voucher = SpreeEltaCourier::PrintVouchers.new(number).call

            Base64.decode64(voucher[:b64_string])
          end

          merged_bytes =
            if decoded_pdfs.size == 1
              decoded_pdfs.first
            else
              combined = CombinePDF.new
              decoded_pdfs.each { |bytes| combined << CombinePDF.parse(bytes) }
              combined.to_pdf
            end

          send_data merged_bytes,
            filename: "#{@order.number}.pdf",
            type: 'application/pdf',
            disposition: 'inline'
        rescue ActiveRecord::RecordNotFound
          render json: {
            error: flash_message_for(Spree::Order.new, :not_found)
          }, status: 404
        rescue StandardError => e
          Rails.logger.error "Elta Courier Error: #{e.message}"

          render json: {
            error: Spree.t('admin.integrations.elta_courier.voucher_print_failed')
          }, status: 400
        end
      end

      private

      def load_order
        @order = current_store.orders.find(params[:order_id])
        authorize! action, @order
        @order
      end

      def order_not_found
        flash[:error] = flash_message_for(Spree::Order.new, :not_found)
        redirect_to spree.admin_orders_path
      end
    end
  end
end
