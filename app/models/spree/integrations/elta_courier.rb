module Spree
  module Integrations
    class EltaCourier < Spree::Integration
      preference :wsdl_url, :string
      preference :customer_code, :string
      preference :user_code, :string
      preference :password, :string
      preference :paper_size, :string, default: "1"

      validates :preferred_wsdl_url, presence: true
      validates :preferred_customer_code, presence: true
      validates :preferred_user_code, presence: true
      validates :preferred_password, presence: true
      validates :preferred_paper_size, presence: true, inclusion: { in: %w[0 1] }

      def self.integration_group
        'shipping'
      end

      def self.icon_path
        'integration_icons/elta-courier-logo.png'
      end
    end
  end
end
