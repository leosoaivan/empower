require 'rails_helper'

RSpec.describe User, type: :feature do
  let (:user) { FactoryGirl.create(:user, name: "Triss Merigold") }
  
  describe "logging in" do
    before :each do
      visit root_path
    end

    context "with correct credentials" do
      before :each do
        fill_in 'username', with: user.username
        fill_in 'password', with: user.password
        click_button 'LOGIN'
      end

      it "flashes a successful message" do
        expect(page).to have_content("Welcome back, #{user.name}.")
      end
      it "redirects a user to their profile" do
        expect(current_path).to eq(user_path(user))
      end
    end

    context "with incorrect credentials" do
      before :each do
        fill_in 'username', with: user.username
        fill_in 'password', with: "foobarbaz"
        click_button 'LOGIN'
      end

      it "flashes a warning" do
        expect(page).to have_content("Invalid username/password combination")
      end
      
      it "re-renders the login page" do
        expect(current_path).to eq(login_path)
      end
    end
  end

  describe "logging out" do
    it "redirects to login" do
      visit root_path
      fill_in 'username', with: user.username
      fill_in 'password', with: user.password
      click_button 'LOGIN'
 
      click_link 'LOGOUT'
      expect(current_path).to eq(login_path)
    end
  end
end