require 'sinatra/base'
require 'sinatra/contrib'

module Webapp
  class InternalController < Sinatra::Base
    register Sinatra::Contrib

    get '/health' do
      json :status => 'ok'
    end

    get '/user' do
      json :users => Services::User.new.run
    end
  end
end