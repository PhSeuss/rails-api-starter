class V1::ApiController < ApplicationController

  def require_login
    authenticate_token || render_unauthorized('Access denied')
  end

  def render_unauthorized(message)
    render json: { error: message }, status: :unauthorized
  end

  def authenticate_token
      auth_content = request.headers['Authorization'] and
      token = auth_content.split(' ').last and
      payload = JWT.decode(token, Rails.application.secrets.secret_key_base, { algorithm: 'HS256'}).first and
      user = User.find(payload['data']['user_id']) and
      user.jwt_matcher == payload['data']['jwt_matcher']
  end
end
