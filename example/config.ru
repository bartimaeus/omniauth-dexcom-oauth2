# Sample app for Dexcom OAuth2 Strategy
# Make sure to setup the ENV variables DEXCOM_CLIENT_ID and DEXCOM_CLIENT_SECRET
# Run with "bundle exec rackup"

require 'bundler/setup'
require 'sinatra/base'
require 'omniauth-dexcom-oauth2'

class App < Sinatra::Base
  get '/' do
    redirect '/auth/dexcom'
  end

  get '/auth/:provider/callback' do
    content_type 'application/json'
    MultiJson.encode(request.env['omniauth.auth'])
  end

  get '/auth/failure' do
    content_type 'application/json'
    MultiJson.encode(request.env)
  end
end

use Rack::Session::Cookie, :secret => 'change_me'

use OmniAuth::Builder do
  provider :dexcom, ENV['DEXCOM_CLIENT_ID'], ENV['DEXCOM_CLIENT_SECRET'], scope: 'user:read'
end

run App.new
