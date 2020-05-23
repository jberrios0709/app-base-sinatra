module Services
  class Crypto
    ENCRYPTION_MODE = 'aes-256-gcm'.freeze

    class << self
      def encrypt(message)
        new_cipher.encrypt_and_sign(message)
      end

      def decrypt(encrypted_message)
        new_cipher.decrypt_and_verify(encrypted_message)
      end

      private

      def new_cipher
        ActiveSupport::MessageEncryptor.new(ENV['SECRET_KEY_CRYPTO'], cipher: ENCRYPTION_MODE)
      end
    end
  end
end
