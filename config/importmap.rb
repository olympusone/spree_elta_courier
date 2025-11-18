pin 'application-spree-elta-courier', to: 'spree_elta_courier/application.js', preload: false

pin_all_from SpreeEltaCourier::Engine.root.join('app/javascript/spree_elta_courier/controllers'),
  under:    'spree_elta_courier/controllers',
  to:       'spree_elta_courier/controllers',
  preload:  'application-spree-elta-courier'
