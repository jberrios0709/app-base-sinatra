class JwtAuth
  def initialize(app, role)
    @app = app
    @role = role
  end

  def call(env)
    begin
      options = { algorithm: 'HS256', iss: ENV['JWT_ISSUER'] }
      bearer = env.fetch('HTTP_AUTHORIZATION', '').slice(7..-1)
      payload, header = JWT.decode bearer, ENV['HMAC_SECRET'], true, options

      env[:user] = payload['user']
      check_role!(payload['user'])
      @app.call env
    rescue ActiveRecord::RecordNotFound, App::Errors::Unauthenticated
      [401, { 'Content-Type' => 'text/plain' }, ['Unauthorized.']]
    rescue JWT::DecodeError
      [401, { 'Content-Type' => 'text/plain' }, ['A token must be passed.']]
    rescue JWT::ExpiredSignature
      [403, { 'Content-Type' => 'text/plain' }, ['The token has expired.']]
    rescue JWT::InvalidIssuerError
      [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid issuer.']]
    rescue JWT::InvalidIatError
      [403, { 'Content-Type' => 'text/plain' }, ['The token does not have a valid "issued at" time.']]
    end
  end

  private

  def check_role!(user_attributes)
    user = Models::User.find_by! user_attributes
    raise App::Errors::Unauthenticated unless @role.include?(user.role.name)
  end
end