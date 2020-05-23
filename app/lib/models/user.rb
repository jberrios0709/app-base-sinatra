module Models
  class User < ApplicationRecord
    validates :name, presence: true
    before_save :encrypt_password, if: :password_changed?

    def decrypt_password
      self.password = Services::Crypto.decrypt(password)
    end

    private

    def encrypt_password
      self.password = Services::Crypto.encrypt(password)
    end
  end
end