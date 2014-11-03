require_relative './sinatra_app'

# require 'rack-lineprof'
# use Rack::Lineprof, profile: /.*/

# require 'stackprof'
# use StackProf::Middleware,
#   enabled: true,
#   mode: :cpu,
#   interval: 10,
#   save_every: 1

run App
