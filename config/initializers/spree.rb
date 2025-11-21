Rails.application.config.after_initialize do
  Rails.application.config.spree.integrations << Spree::Integrations::EltaCourier

  # Admin partials
  Rails.application.config.spree_admin.order_page_dropdown_partials << 'spree_elta_courier/order_dropdown_options'
end
