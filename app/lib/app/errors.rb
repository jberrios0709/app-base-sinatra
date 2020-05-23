module App
  module Errors
    class Unauthenticated < StandardError; end
    class Unauthorized < StandardError; end
  end
end