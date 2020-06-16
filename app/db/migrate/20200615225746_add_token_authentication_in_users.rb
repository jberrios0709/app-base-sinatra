class AddTokenAuthenticationInUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :token_authenticator, :string
  end
end
