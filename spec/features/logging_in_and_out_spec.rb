require 'rails_helper'

feature 'Login management' do
  let (:user) { FactoryGirl.create(:user, name: "Triss Merigold") }
  
  describe "authenticating" do
    context "when not logged in" do
      before :each do
        visit clients_path
      end

      it "redirects to login" do
        expect(current_path).to eql(login_path)
      end

      it "flashes a warning message" do
        expect(page).to have_content("Please log in to continue")
      end
    end
  end
  describe "logging in" do
    before :each do
      visit root_path
    end

    context "with correct credentials" do
      before :each do
        log_in(user)
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
      log_in(user)

      click_link 'LOGOUT'
      expect(current_path).to eq(login_path)
    end
  end
end