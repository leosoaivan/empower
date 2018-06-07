module FeatureHelper
  def log_in(user)
    visit login_path
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'LOGIN'
  end
end

RSpec.configure do |config|
  config.include FeatureHelper, type: :feature
end