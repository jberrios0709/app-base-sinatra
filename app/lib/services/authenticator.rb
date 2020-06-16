require 'rotp'

module Services
  class Authenticator
    TOKEN_LENGTH = 16.freeze
    ISSUER = 'Kriptonmarket'.freeze

    def initialize(user)
      @user = user
    end

    def current_token
      authenticator = totp
      authenticator.now
    end

    def verify(token)
      authenticator = totp
      !authenticator.verify(token).nil?
    end

    def associate_with_user
      @user.update(token_authorization: generate_token_uniq) if @user.token_authenticator.nil?
      generate_qr
    end

    def generate_qr
      authenticator = totp
      authenticator.provisioning_uri(@user.username)
    end

    private

    def totp
      ROTP::TOTP.new(@user.token_authenticator, issuer: ISSUER)
    end

    def generate_token_uniq
      token = generate_token
      loop do
        break unless Models::User.find_by(token_authenticator: token).present?
        token = generate_token
      end
      token
    end

    def generate_token
      Services::Utils.generate_string(TOKEN_LENGTH)
    end
  end
end