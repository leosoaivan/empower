module FeatureHelper
  def log_in(user)
    visit root_path
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'LOGIN'
  end

  def search_for_client(id)
    visit clients_path
    fill_in 'id', with: id
    click_on 'Search'
    click_on 'VIEW'
  end
end

module ControllerHelper
  def login(user)
    # user = User.where(:login => user.to_s).first if user.is_a?(Symbol)
    request.session[:user_id] = user.id
  end

  def current_user
    User.find(request.session[:user_id])
  end
end

RSpec.configure do |config|
  config.include FeatureHelper, type: :feature
  config.include ControllerHelper, type: :controller
end