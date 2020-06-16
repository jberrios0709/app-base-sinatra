module Services
  class User
    def initialize(parse_body, role = 2)
      @params = parse_body
      @role = Models::Role.find role
    end

    def create!
      @user = Models::User.create(user_attributes)
      Models::Profile.create(
        profile_attributes
      )
      Mailers::NotifyCreate.deliver(user: @user) if Constants::MAILS_ENABLED
      Mailers::Welcome.deliver(user: @user) if Constants::MAILS_ENABLED
      @user.sanitize_data
    end

    class << self
      def restore_password!(username)
        user = Models::User.find_by!(username: username)
        raise App::Errors::ActionDuplicate unless
          user.permit_action_token?(Constants::ACTIONS_TOKENS[:restore_password])

        token = Services::Utils.generate_string
        token_action = Models::TokenAction.new(action: Constants::ACTIONS_TOKENS[:restore_password], token: token)
        user.token_actions << token_action
        Mailers::ResetPassword.deliver(user: user, token: token) if Constants::MAILS_ENABLED
      end

      def change_password!(user, data)
        raise App::Errors::Unauthorized if user.decrypt_password != data['current_password']
        user.update(password: data['new_password'])
      end
    end

    private

    def user_attributes
      {
        username: @params['username'],
        password: @params['password'],
        role: @role
      }
    end

    def profile_attributes
      {
        first_name: @params['first_name'],
        last_name: @params['last_name'],
        cellphone: @params['cellphone'],
        user_id: @user.id
      }
    end
  end
end