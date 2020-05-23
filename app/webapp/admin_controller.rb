require 'sinatra/base'
require 'sinatra/contrib'

module Webapp
  class AdminController < App::Base
    register Sinatra::Contrib
    use JwtAuth

    get '/user/:id' do
      begin
        json :data => Models::User.find(params['id'])
      rescue ActiveRecord::RecordNotFound
        status 404
        json :error => :not_found
      end
    end

    patch '/user/:id' do
      begin
        json :data => Models::User.find(params['id']).update(parse_body)
      rescue ActiveRecord::RecordNotFound
        status 404
        json :error => :not_found
      end
    end

    post '/user' do
      begin
        json :data => Models::User.create(parse_body)
      rescue ActiveRecord::RecordNotUnique
        status 400
        json :error => :bad_request, :message => Constants::ERRORS[:username_already]
      rescue StandardError => e
        status 422
        json :error => :unprocessable_entity, :message => e
      end
    end

    delete '/user/:id' do
      begin
        Models::User.delete(params['id'])
        json :data => Constants::ERRORS[:register_delete]
      rescue ActiveRecord::RecordNotFound
        status 404
        json :error => :not_found
      end
    end
  end
end