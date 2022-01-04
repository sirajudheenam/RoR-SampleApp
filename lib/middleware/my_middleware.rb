class MyMiddleware
  def initialize app
    @app = app
  end

  def call env
    # do something
    puts "My first middleware.. haven't you seen??"
    [200, {"Content-Type" => "text/html"}, ["Hello World"]]
  end
end
