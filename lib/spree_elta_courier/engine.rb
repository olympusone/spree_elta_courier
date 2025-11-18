module SpreeEltaCourier
  class Engine < Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_elta_courier'

    # use rspec for tests
    config.generators do |g|
      g.test_framework :rspec
    end

    initializer 'spree_elta_courier.environment', before: :load_config_initializers do |_app|
      SpreeEltaCourier::Config = SpreeEltaCourier::Configuration.new
    end

    initializer 'spree_elta_courier.assets' do |app|
      app.config.assets.paths << root.join('app/javascript')
      app.config.assets.precompile += %w[spree_elta_courier_manifest]
    end

    initializer 'spree_elta_courier.importmap', after: 'spree.admin.importmap' do |app|
      app.config.spree_admin.importmap.draw(root.join('config/importmap.rb'))

      app.config.spree_admin.cache_sweepers << root.join('app/javascript')
    end

    initializer 'spree_elta_courier.cache_sweeper', before: 'spree.admin.importmap.cache_sweeper' do |app|
      app.config.spree_admin.cache_sweepers << root.join('app/javascript')
    end

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), '../../app/**/*_decorator*.rb')) do |c|
        Rails.configuration.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
