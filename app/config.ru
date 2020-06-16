require_relative 'webapp/admin/admin_controller'
require_relative 'webapp/user/user_controller'
require_relative 'webapp/public_controller'
require_relative 'lib/configuration'

run Rack::URLMap.new(
  {
    '/admin/v1' => Webapp::Admin::AdminController,
    '/user/v1' => Webapp::User::UserController,
    '/public/v1' => Webapp::PublicController
  }
)