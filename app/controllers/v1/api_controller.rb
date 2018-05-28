class V1::ApiController < ApplicationController

  def require_login
    authenticate_token || render_unauthorized('Access denied')
  end

  protected
  def current_user
    @user
  end

  def unauthenticate_token
    @user.jwt_matcher = nil
    head :ok if @user.save
  end

  def render_unauthorized(message)
    render json: { error: message }, status: :unauthorized
  end

  private
  def authenticate_token
      token = request.headers['Authorization'] and
      token = token.split(' ').last and
      payload = JWT.decode(token, Rails.application.secrets.secret_key_base, { algorithm: 'HS256'}).first and
      @user = User.find(payload['data']['user_id']) and
      @user.jwt_matcher == payload['data']['jwt_matcher']
  end
end
