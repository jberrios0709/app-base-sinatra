require 'sinatra/base'
require 'sinatra/contrib'

module Webapp
  class PublicController < App::Base
    register Sinatra::Contrib

    get '/health' do
      json :status => 'ok'
    end

    post '/login' do
      begin
        security = Services::Security.login(parse_body)
        json :data => security.login!
      rescue App::Errors::Unauthorized
        status 401
        json :error => :unautohorized
      end
    end
  end
end