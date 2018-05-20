class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  
  # Devise
  before_action :authenticate_user!

  rescue_from CanCan::AccessDenied do |exception|
    flash[:danger] = exception.message
    redirect_back(fallback_location: authenticated_root_path)
  end

  def current_ability
    current_user.ability
  end
end