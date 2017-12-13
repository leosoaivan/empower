module SpecHelper
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

RSpec.configure do |config|
  config.include SpecHelper, type: :feature
end