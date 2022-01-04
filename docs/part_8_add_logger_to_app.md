
on environment.rb file, add the following

```ruby
Rails.logger = Logger.new(STDOUT)
Rails.logger.level = Logger::DEBUG
Rails.logger.datetime_format = "%Y-%m-%d %H:%M:%S"
config.logger = ActiveSupport::Logger.new("log/#{Rails.env}.log")
```

<!-- https://stackify.com/rails-logger-and-rails-logging-best-practices/ -->