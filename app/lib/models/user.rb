module Models
  class User < ApplicationRecord
    has_many :blogs
    has_many :simulations
    has_many :token_actions
    belongs_to :role
    has_one :profile

    validates :username, :password, presence: true
    before_save :encrypt_password, if: :password_changed?

    def decrypt_password
      self.password = Services::Crypto.decrypt(password)
    end

    def sanitize_data
      {
        id: id,
        username: username,
        token: token_authenticator,
        profile: profile,
        role: role
      }
    end

    def permit_action_token?(action)
      yesterday = Time.now - (24*3600)
      token_actions
        .where(action: action)
        .where('created_at > ?', yesterday).count > 0 ? false : true
    end

    private

    def encrypt_password
      self.password = Services::Crypto.encrypt(password)
    end
  end
end