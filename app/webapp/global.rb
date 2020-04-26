require_relative '../lib/configuration'
require_relative './internal_controller'

module Webapp
  class Global < Sinatra::Base
    register Sinatra::ActiveRecordExtension
    use InternalController
  end
end