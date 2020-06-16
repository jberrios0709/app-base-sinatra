require 'sinatra/base'
require 'sinatra/contrib'

module Webapp
  class PublicController < App::Base
    register Sinatra::ActiveRecordExtension
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

    post '/restore_password' do
      begin
        email = parse_body['email'].present? ? parse_body['email']:''
        Services::User.restore_password!(email)
        json :data => 'Email send'
      rescue App::Errors::ActionDuplicate
        status 202
        json :error => Constants::ERRORS[:action_repeat]
      rescue ActiveRecord::RecordNotFound
        status 404
        json :error => :not_found
      end
    end
  end
end