class V1::SessionsController < V1::ApiController
  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.valid_password?(params[:password])
      @user.jwt_matcher = rand(1000000).to_s
      if @user.save
        payload = { user_id: @user.id, jwt_matcher: @user.jwt_matcher }
        jwt = JWT.encode(
          { data: payload, exp: (Time.now + 2.days).to_i },
          Rails.application.secrets.secret_key_base,
          'HS256'
        )
        render :create, status: :created, locals: { token: jwt }
      else
        head(:unauthorized)
      end
    else
      head(:unauthorized)
    end
  end
  
  def destroy

  end
end