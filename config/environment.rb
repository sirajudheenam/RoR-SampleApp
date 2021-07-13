# Load the Rails application.
require_relative "application"

# Initialize the Rails application.
Rails.application.initialize!

# Logger Customization - AMS
# Rails.logger = Logger.new(STDOUT)
# Rails.logger.level = Logger::DEBUG
# Rails.logger.datetime_format = "%Y-%m-%d %H:%M:%S"
# Rails.logger do |config|
#     config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")
# end

