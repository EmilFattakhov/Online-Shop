# rails g controller api/v1/sessions --no-assets --no-helper --skip-template-engine
# 👆🏻Command to generate Api/v1/SessionController
class Api::V1::SessionsController < Api::ApplicationController
  # 👆🏻Replace ApplicationController with Api::ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { id: user.id }
    else
      render(
        json: { status: 404 },
        status: 404,
      )
    end
  end

  def get_current_user_from_session
    render json: current_user
  end
end
