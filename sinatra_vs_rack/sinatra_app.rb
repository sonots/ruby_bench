require 'sinatra/base'

class App < Sinatra::Base
  set :logging, false
  get '/' do
    ""
  end
end
