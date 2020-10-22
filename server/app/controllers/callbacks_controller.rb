class CallbacksController < ApplicationController
  def index
    oauth_data=request.env["omniauth.auth"]
    # p oauth_data
    user = User.find_by_oauth(oauth_data)
    user ||=User.create_from_oauth(oauth_data)
    if user.valid?
      session[:user_id]=user.id
      flash[:success]="Thank you for Signing up with #{oauth_data["provider"].capitalize!}"
    else
      flash[:danger]=user.errors.full_messages.join(", ")
    end
    redirect_to root_path
  end
end
