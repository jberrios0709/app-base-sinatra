module Services
  class User
    def run
      Models::User.all
    end
  end
end