Rails.application.config.after_initialize do
  Spree.integrations << Spree::Integrations::EltaCourier

  # Admin partials
  Spree.admin.partials.head << 'spree_elta_courier/head'
  Spree.admin.partials.order_page_dropdown << 'spree_elta_courier/order_dropdown_options'
  Spree.admin.partials.shipping_method_form << 'spree/admin/shipping_methods/elta_courier_form'

  Spree::PermittedAttributes.shipping_method_attributes << :elta_courier
end
