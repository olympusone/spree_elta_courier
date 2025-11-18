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

import EltaCourierController from 'spree_elta_courier/controllers/elta_courier_controller'

application.register('elta-courier', EltaCourierController)
