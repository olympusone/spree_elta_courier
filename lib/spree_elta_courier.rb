require 'spree_core'
require 'spree_extension'
require 'spree_elta_courier/engine'
require 'spree_elta_courier/version'
require 'spree_elta_courier/configuration'

module SpreeEltaCourier
  def self.queue
    'default'
  end
end