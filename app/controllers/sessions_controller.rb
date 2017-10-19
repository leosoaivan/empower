class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      log_in user
      flash[:success] = "Welcome back, #{user.name}."
      redirect_to user_path(user)
    else
      flash.now[:danger] = "Invalid username/password combination"
      render :new
    end
  end

  def destroy
    log_out
    redirect_to login_path
  end
end
