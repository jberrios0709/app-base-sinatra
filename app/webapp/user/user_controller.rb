require 'sinatra/base'
require 'sinatra/contrib'

module Webapp
  module User
    class UserController < App::Base
      register Sinatra::Contrib
      register Sinatra::ActiveRecordExtension
      use JwtAuth, Constants::ROLES_JWT[:user]

      post '/change_password' do
        begin
          Services::User.change_password!(current_user!, parse_body)
          json :data => :ok
        rescue App::Errors::Unauthorized
          status 401
          json :error => :unauthorized
        rescue ActiveRecord::RecordNotFound
          status 404
          json :error => :not_found
        end
      end

      get '/user' do
        begin
          json :data => current_user!.sanitize_data
        rescue ActiveRecord::RecordNotFound
          status 404
          json :error => :not_found
        end
      end

      post '/authenticator/enable' do
        begin
          json :data => CGI.escape(Services::Authenticator.new(current_user!).associate_with_user)
        rescue ActiveRecord::RecordNotFound
          status 404
          json :error => :not_found
        end
      end
    end
  end
end