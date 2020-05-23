require_relative 'webapp/global'

run Rack::URLMap.new(
  {
    '/v1' => Webapp::Global
  }
)