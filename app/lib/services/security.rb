require 'jwt'
module Services
  class Security

    def initialize(params)
      @params = params
    end

    def login!
      user = Models::User.find_by(username: @params['username'])

      return generate_token if user.present? && user.decrypt_password === @params['password']

      raise App::Errors::Unauthorized
    end

    class << self
      def login(params)
        self.new(params)
      end
    end

    private

    def generate_token
      {
        token: (JWT.encode payload_username, ENV['HMAC_SECRET'], 'HS256')
      }
    end

    def payload_username
      {
        exp: Time.now.to_i + 60 * 60,
        iat: Time.now.to_i,
        iss: ENV['JWT_ISSUER'],
        user: {
          username: @params['username']
        }
      }
    end
  end
end