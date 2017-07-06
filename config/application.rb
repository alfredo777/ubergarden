require_relative 'boot'
require 'rails/all'
require 'carrierwave'
require 'carrierwave/orm/activerecord'
Bundler.require(*Rails.groups)

module Ubergarden
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end

$FANCY = true
