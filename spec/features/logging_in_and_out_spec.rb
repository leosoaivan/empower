require 'rails_helper'

feature 'Login management -' do
  let (:user) { create(:user) }
  let (:alert_danger) { '.flash__alert--danger' }
  let (:alert_success) { '.flash__alert--success' }
  
  describe 'authenticating' do
    context 'when not logged in' do
      it 'flashes a danger message' do
        visit clients_path
        expect(page).to have_css '#flash'
      end

      it 'redirects a user to login' do
        visit clients_path
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'logging in' do
    context 'with correct credentials' do
      before :each do
        visit login_path
        log_in user
      end

      it 'flashes a success message' do
        expect(page).to have_css '#flash'
      end

      it 'redirects a user to their profile' do
        expect(current_path).to eq authenticated_root_path

        within 'nav' do
          expect(page).to have_content(user.username)
        end
      end
    end

    context 'with incorrect credentials' do
      before :each do
        visit login_path
        fill_in 'username', with: user.username
        fill_in 'password', with: 'foobarbaz'
        click_button 'LOGIN'
      end

      it 'flashes a danger message' do
        expect(page).to have_css '#flash'
      end
      
      it 're-renders the login page with form' do
        expect(current_path).to eq user_session_path
      end
    end
  end

  describe 'logging out' do
    before :each do
      visit login_path
      log_in user
      click_on 'LOGOUT'
    end

    it 'flashes a success message' do
      expect(page).to have_css '#flash'
    end
    
    it 'redirects to login' do
      expect(current_path).to eq login_path
    end

    it 'prevents access to non-login pages' do
      visit clients_path
      
      expect(current_path).to eq login_path
      expect(current_path).to_not eq clients_path
    end
  end
end