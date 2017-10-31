class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :require_login
  
  include SessionsHelper

  def require_login
    unless logged_in?
      flash[:danger] = "Please log in to continue"
      redirect_to login_path
    end
  end
end
