# Part 7 - Create a middleware


```ruby

# create a file called "lib/response_timer.rb"

# on `config/application.rb`

require_relative
Rails::Initializer.run do |config|

    config.middleware.use ResponseTimer

....
end

# Run Rake
rake middleware
# Restart the App Server
rails server



```
