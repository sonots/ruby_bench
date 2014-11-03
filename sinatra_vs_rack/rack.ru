require_relative './rack_app'

# require 'rack-lineprof'
# use Rack::Lineprof, profile: /.*/

run App.new
