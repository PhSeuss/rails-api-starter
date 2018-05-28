class V1::ApiController < ApplicationController

  def require_login
    authenticate_token || render_unauthorized('Access denied')
  end

  def render_unauthorized(message)
    render json: { error: message }, status: :unauthorized
  end

  def authenticate_token
    return (
      (token = request.headers['Authorization']) &&
      (token = token.split(' ').last) &&
      (payload = JWT.decode(token, Rails.application.secrets.secret_key_base, { algorithm: 'HS256'}).first) &&
      (user = User.find(payload['data']['user_id'])) &&
      (user.jwt_matcher == payload['data']['jwt_matcher'])
    )
  end
end
