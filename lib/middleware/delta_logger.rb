VALID_LOG_LEVELS = [:debug, :info, :warn, :error, :fatal, :unknown]
class DeltaLogger
    def initialize app, log_level
      @app = app
      # Default to :info log level if the user sets an invalid log level.
      @log_level = VALID_LOG_LEVELS.include?(log_level) ?  log_level : :inf
    end
  
    def call env
      dup._call env
    end

    def _call env
      request_started_on = Time.now
      @status, @headers, @response = @app.call(env)
      request_ended_on = Time.now
  
      Rails.logger.debug "=" * 50
      Rails.logger.debug "Request delta time: #{request_ended_on - request_started_on} seconds."
      Rails.logger.debug "=" * 50
  
      [@status, @headers, @response]
    end
end
