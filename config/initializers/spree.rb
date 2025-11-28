Rails.application.config.after_initialize do
  Spree.integrations << Spree::Integrations::EltaCourier

  # Admin partials
  Spree.admin.partials.head << 'spree_elta_courier/head'
  Spree.admin.partials.order_page_dropdown << 'spree_elta_courier/order_dropdown_options'
end
