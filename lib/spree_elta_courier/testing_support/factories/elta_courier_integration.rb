FactoryBot.define do
  factory :elta_courier_integration, class: Spree::Integrations::EltaCourier do
    active { true }
    preferred_wsdl_url { ENV['ELTA_COURIER_WSDL_URL'] }
    preferred_customer_code { ENV['ELTA_COURIER_CUSTOMER_CODE'] }
    preferred_username { ENV['ELTA_COURIER_USERNAME'] }
    preferred_password { ENV['ELTA_COURIER_PASSWORD'] }
    store { Spree::Store.default }
  end
end
