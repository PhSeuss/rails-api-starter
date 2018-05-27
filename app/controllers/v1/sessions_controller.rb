class V1::SessionsController < ApplicationController
  def create
    @user = User.find_by_email(params[:email])

    if @user && @user.valid_password?(params[:password])
      jwt = JWT.encode(
        { user_id: @user.id, exp: (Time.now + 2.days).to_i },
        Rails.application.secrets.secret_key_base,
        'HS256'
      )
      render :create, status: :created, locals: { token: jwt}
    else
      head(:unauthorized)
    end
  end
  
  def destroy

  end
end