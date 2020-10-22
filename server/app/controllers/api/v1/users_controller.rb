class Api::V1::UsersController < Api::ApplicationController
  def create
    user = User.new params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :avatar, :address)
    if user.save
      session[:user_id] = user.id
      render json: {user: user, avatar_url: url_for(user.avatar)}
    else
      render json: { error: user.errors }
    end
  end
end
