require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module CtAdvisorInt
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    config.action_dispatch.default_headers.clear

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.perform_deliveries = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.smtp_settings = {
               address:              ENV['SMTP_HOST'],
               port:                 587,
               domain:               'lolware.net',
               user_name:            ENV['SMTP_USER'],
               password:             ENV['SMTP_PASS'],
               authentication:       'plain',
               enable_starttls_auto: true  }

  end
end
