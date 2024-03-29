require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Fb
  class Application < Rails::Application

    config.load_defaults 5.2
    Rails.application.config.assets.unknown_asset_fallback = true
    config.time_zone = 'Tokyo'
    config.active_record.default_timezone = :local
    config.i18n.default_locale = :ja

    config.load_defaults 5.1
    config.generators do |g|
      g.assets false
      g.helper false
    end

    config.generators do |g|
      g.test_framework :rspec,
        fixtures: true,
        view_specs: false,
        helper_specs: false,
        routing_specs: false,
        controller_specs: false,
        request_specs: false
      g.fixture_replacement :factory_bot, dir: "spec/factories"
    end
  end
end
