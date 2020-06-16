require 'sinatra/base'
require 'sinatra/contrib'
require_relative '../../lib/configuration'
require_relative './users_controller'

module Webapp
  module Admin
    class AdminController < App::Base
      register Sinatra::Contrib
      register Sinatra::ActiveRecordExtension
      use JwtAuth, Constants::ROLES_JWT[:admin]
      use UsersController
    end
  end
end