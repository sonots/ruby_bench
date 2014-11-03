require 'rack'

class App
  def call(env)
    [200, {"Content-Type" => "text/plain"}, ["rack up!\n"]]
  end
end
