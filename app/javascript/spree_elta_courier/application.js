import '@hotwired/turbo-rails'
import { Application } from '@hotwired/stimulus'

let application

if (typeof window.Stimulus === "undefined") {
  application = Application.start()
  application.debug = false
  window.Stimulus = application
} else {
  application = window.Stimulus
}

import SpreeEltaCourierController from 'spree_elta_courier/controllers/spree_elta_courier_controller'

application.register('spree-elta-courier', SpreeEltaCourierController)
