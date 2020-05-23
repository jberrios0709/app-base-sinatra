module App
  class Base < Sinatra::Base
    helpers do
      def parse_body
        request.body.rewind
        JSON.parse(request.body.read)
      end
    end
  end
end