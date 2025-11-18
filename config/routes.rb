Spree::Core::Engine.add_routes do
  namespace :admin, path: Spree.admin_path do
    post  'elta_courier/:order_id/create',      to: 'elta_courier#create',      as: :elta_courier_create
    get   'elta_courier/:order_id/print',       to: 'elta_courier#print',       as: :elta_courier_print
  end
end
