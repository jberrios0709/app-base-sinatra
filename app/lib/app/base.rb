module App
  class Base < Sinatra::Base
    helpers do
      def parse_body
        request.body.rewind
        JSON.parse(request.body.read)
      end

      def current_user!
        begin
          Models::User.find_by(request.env[:user])
        rescue ActiveRecord::RecordNotFound
          raise App::ERRORS::Unauthorized
        end
      end
    end
  end
end
