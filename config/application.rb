require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env)

module Hellper
  class Application < Rails::Application
    # Load up all of the environment specific configuration values to be used
    application_config = YAML.load_file(Rails.root.join('config', 'application.yml'))[Rails.env]
    config.secret_key_base = application_config['secret_key_base']

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    config.i18n.default_locale = :en
    config.i18n.enforce_available_locales = true
    I18n.config.enforce_available_locales = true

    config.autoload_paths += %W[#{Rails.root}/lib]

    config.generators do |g|
      g.test_framework :rspec,
                       fixtures: false,
                       view_specs: false,
                       helper_specs: false,
                       routing_specs: false,
                       controller_specs: true,
                       request_specs: true
    end

    # Email Settings                                                                                                ##
    config.action_mailer.default_url_options = {
        :host => application_config['email']['default_host'],
        :protocol => application_config['email']['default_protocol']
    }
    config.action_mailer.raise_delivery_errors =
      application_config['email']['raise_delivery_errors']
    config.action_mailer.delivery_method = application_config['email']['delivery_method']
    if config.action_mailer.delivery_method == :smtp
      smtp_options = {
          address:  application_config['email']['address'],
          port: application_config['email']['port']
      }
      config.action_mailer.smtp_settings = smtp_options
    end
    config.customer_notification_email_address =
      application_config['email']['customer_notification_email_address']
  end
end
