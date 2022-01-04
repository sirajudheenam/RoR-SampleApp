# Middleware that will make Rack-based apps CORS compatible.
# find more about it on https://github.com/cyu/rack-cors
# more on CORS: https://developer.mozilla.org/en-US/docs/Web/HTTP/CORS
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # origins '*'
	origins 'http://localhost:3000'
    resource '*', 
    	headers: :any, 
    	methods: [:get, :post, :patch, :put, :delete, :options, :head]
  end
end