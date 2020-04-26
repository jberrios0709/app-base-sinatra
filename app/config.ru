require_relative 'webapp/global'

map '/' do
  run Webapp::Global
end