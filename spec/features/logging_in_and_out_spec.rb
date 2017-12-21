require 'rails_helper'

feature 'Login management' do
  let (:user) { FactoryGirl.create(:user, name: "Triss Merigold") }
  let (:alert_danger) { ".flash__alert--danger" }
  let (:alert_success) { ".flash__alert--success" }
  
  describe "authenticating" do
    context "when not logged in" do
      it "flashes a danger message" do
        visit clients_path
        expect(page).to have_css alert_danger
      end

      it "redirects a user to login" do
        visit clients_path
        expect(current_path).to eq login_path
      end
    end
  end

  describe "logging in" do
    context "with correct credentials" do
      it "flashes a success message" do
        visit root_path
        log_in user
        expect(page).to have_css alert_success
      end

      it "redirects a user to their profile" do
        visit root_path
        log_in user
        expect(current_path).to eq user_path(user)
      end
    end

    context "with incorrect credentials" do
      it "flashes a danger message" do
        visit root_path
        fill_in 'username', with: user.username
        fill_in 'password', with: "foobarbaz"
        click_button 'LOGIN'
        expect(page).to have_css alert_danger
      end
      
      it "re-renders the login page" do
        visit root_path
        fill_in 'username', with: user.username
        fill_in 'password', with: "foobarbaz"
        click_button 'LOGIN'
        expect(current_path).to eq login_path
      end
    end
  end

  describe "logging out" do
    before :each do
      log_in user
      click_on 'LOGOUT'
    end

    it "flashes a success message" do
      expect(page).to have_css alert_success
    end
    
    it "redirects to login" do
      expect(current_path).to eq login_path
    end

    it "prevents access to non-login pages" do
      visit clients_path
      expect(current_path).to_not eq clients_path
    end
  end
end