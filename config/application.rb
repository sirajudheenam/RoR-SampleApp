require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

# Middleware inclusion by Sam on 12 Jul 2021
# require_relative  "../lib/middleware/response_timer"
# require_relative "../lib/middleware/delta_logger"
# require_relative '../lib/middleware/my_middleware'
# require_relative "../lib/middleware/delta_formatter"
# require_relative "../lib/middleware/loggster"
# require_relative "../lib/middleware/test_handler"

module SampleApp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1
    
    # https://ieftimov.com/post/writing-rails-middleware/

    # config.middleware.use ResponseTimer, "Rezponse Tyme"
    # config.middleware.insert_before Rails::Rack::Logger, ResponseTimer, "Rezponse Tyme"
    # config.middleware.use MiddlewareOne

    # config.autoload_paths += Dir["#{config.root}/lib/**/"]
    # config.middleware.insert_before Rails::Rack::Logger, MyMiddleware
    # config.middleware.use MyMiddleware
    # config.middleware.use ResponseTimer
    # config.middleware.insert_before Rails::Rack::Logger, DeltaLogger, :warn
    # config.log_formatter = DeltaFormatter.new

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    
    # Include the authenticity token in remote forms.
    config.action_view.embed_authenticity_token_in_remote_forms = true

    # rails to use haml for scaffold generators.
    config.generators do |g|
      g.template_engine :haml

      # you can also specify a different test framework or ORM here
      # g.test_framework  :rspec
      # g.orm             :mongoid
    end 

    # Add logger - AMS
    # Simple logging - works
    # config.logger = Logger.new(STDOUT)
    # Tagged Logging
    config.logger = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))
    config.log_level = :debug
    # Examples
    # logger.tagged("BCX") { logger.info "Stuff" }                            # Logs "[BCX] Stuff"
    # logger.tagged("BCX", "Jason") { logger.info "Stuff" }                   # Logs "[BCX] [Jason] Stuff"
    # logger.tagged("BCX") { logger.tagged("Jason") { logger.info "Stuff" } } # Logs "[BCX] [Jason] Stuff"

  end


end
