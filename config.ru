require 'lims-support-app'

Lims::Api::Server.configure(:development) do |config|
require 'lims-api/sequel'
require 'lims-api/message_bus'
  store = Lims::Api::Sequel::create_store(:development)
  message_bus = Lims::Api::MessageBus::create_message_bus(:development)
  config.set :context_service, Lims::Api::ContextService.new(store, message_bus)
  config.set :base_url, "http://localhost:9292"
end

class LoggerMiddleware

  def initialize(app, logger)
    @logger = logger
    @app = app
  end

  def call(env)
    began_at = Time.now
    log_data = "#{env["REQUEST_METHOD"]} #{env["PATH_INFO"]}"

    # log the beginning of the request
    log("[start] #{log_data}")

    begin
      status, header, body = @app.call(env)

      # log our custom generated HTTP errors
      logerror(body) unless [200, 201].include?(status)

      # log the finishing of the request (sending of the response)
      log("[finish] #{log_data}", began_at)
      [status, header, body]
    rescue StandardError, LoadError, SyntaxError => e
      exception_string = dump_exception(e)

      # log the caught exception
      logerror([exception_string])
    end
  end

  # log the given string with INFO level
  def log(log_str, began_at=nil)
    unless began_at.nil?
      spent_time = Time.now - began_at
      log_str += " in #{spent_time.to_s}"
    end

    @logger.info { log_str }
  end

  # log the error messages/exceptions with ERROR level
  def logerror(errors)
    errors.each { |message|
      @logger.error { message }
    }
  end

  # assamle the caught exception and its back trace to a string
  def dump_exception(exception)
    string = "#{exception.class}: #{exception.message}\n"
    string << exception.backtrace.map { |l| "\t#{l}" }.join("\n")
    string
  end
end

logger = Logger.new($stdout)

use LoggerMiddleware, logger

run Lims::Api::Server
