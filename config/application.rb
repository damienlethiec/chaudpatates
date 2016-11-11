require_relative 'boot'

require 'rails/all'
require "sprockets/railtie"
require "attachinary/orm/active_record"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Chaudpatates
  class Application < Rails::Application
  	config.i18n.default_locale = :fr
  	config.active_job.queue_adapter = :sidekiq
  	config.action_view.embed_authenticity_token_in_remote_forms = true
  	config.time_zone = 'Paris'
  	config.exceptions_app = self.routes
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
