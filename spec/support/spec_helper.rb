module SpecHelper
  def log_in(user)
    visit root_path
    fill_in 'username', with: user.username
    fill_in 'password', with: user.password
    click_button 'LOGIN'
  end
end

RSpec.configure do |config|
  config.include SpecHelper, type: :feature
end