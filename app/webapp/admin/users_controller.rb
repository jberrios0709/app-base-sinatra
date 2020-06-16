module Webapp
  module Admin
    class UsersController < App::Base
      get '/user/:id' do
        begin
          json :data => Models::User.find(params['id']).sanitize_data
        rescue ActiveRecord::RecordNotFound
          status 404
          json :error => :not_found
        end
      end

      post '/user' do
        begin
          json :data => Services::User.new(parse_body).create!
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
end
