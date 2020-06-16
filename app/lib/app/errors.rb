module App
  module Errors
    class Unauthenticated < StandardError; end
    class Unauthorized < StandardError; end
    class CategoryNotFound < StandardError; end
    class ActionDuplicate < StandardError; end
  end
end