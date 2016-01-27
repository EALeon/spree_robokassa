module SpreeRobokassa
  class Engine < Rails::Engine
    require 'spree/core'

    config.autoload_paths += %W(#{config.root}/lib)

    def self.activate
      Dir.glob(File.join(File.dirname(__FILE__), "../app/**/*_decorator*.rb")) do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
      #Spree::Gateway::Robokassa.register
    end

    config.to_prepare &method(:activate).to_proc

    initializer 'spree.robokassa.payment_methods', after: "spree.register.payment_methods" do |app|
      app.config.spree.payment_methods << Spree::Gateway::Robokassa
    end

  end
end
