require 'lims-support-app'
require 'logger-middleware'

Lims::Api::Server.configure(:development) do |config|
require 'lims-api/sequel'
require 'lims-api/message_bus'
  store = Lims::Api::Sequel::create_store(:development)
  message_bus = Lims::Api::MessageBus::create_message_bus(:development)
  config.set :context_service, Lims::Api::ContextService.new(store, message_bus)
  config.set :base_url, "http://localhost:9292"
end

ENV["LIMS_SUPPORT_ENV"] = "development" unless ENV["LIMS_SUPPORT_ENV"]
env = ENV["LIMS_SUPPORT_ENV"]
cas_settings = YAML.load_file(File.join("config", "cas_database.yml"))[env]
sequencescape_settings = YAML.load_file(File.join("config", "sequencescape_database.yml"))[env]
Lims::SupportApp::Util::DBHandler.db_initialize(cas_settings, sequencescape_settings)

logger = Logger.new($stdout)

use LoggerMiddleware, logger

run Lims::Api::Server
