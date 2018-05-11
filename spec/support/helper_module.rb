module FeatureHelper
  def log_in(user)
    visit login_path
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

RSpec.configure do |config|
  config.include FeatureHelper, type: :feature
end