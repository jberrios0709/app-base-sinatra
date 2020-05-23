require_relative '../lib/configuration'
require_relative './public_controller'
require_relative './admin_controller'

module Webapp
  class Global < App::Base
    register Sinatra::ActiveRecordExtension
    use PublicController
    use AdminController
  end
end