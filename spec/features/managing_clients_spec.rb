require 'rails_helper'

feature 'Client management' do
  let (:user)   { create(:user) }
  let (:client) { create(:client) }
  let (:alert_danger) { ".flash__alert--danger" }
  let (:alert_success) { ".flash__alert--success" }

  before :each do
    log_in user
    search_for_client client.id
  end

  describe "editing a client" do
    before :each do
      click_on 'Edit'
    end

    it "redirects a user to the client's edit page" do
      expect(current_path).to eql edit_client_path(client)
    end

    it "displays an edit form" do
      expect(page).to have_css "form"
    end

    context "with valid attributes" do
      before :each do
        fill_in 'firstname', with: "Jack"
        fill_in 'lastname', with: "Black"
        click_on 'Update'
      end
      
      it "flashes a successful message" do
        expect(page).to have_css alert_success
      end

      it "redirects a user back to the client's page" do
        expect(current_path).to eql client_path(client)
      end

      it "displays the updated attributes" do
        expect(page).to have_content "Jack Black"
      end
    end

    context "with invalid attributes" do
      before :each do
        fill_in 'firstname', with: "Jack"
        fill_in 'lastname', with: ""
        click_button 'Update'
      end
      
      it "flashes a danger message" do
        expect(page).to have_css alert_danger
      end

      it "returns the edit form" do
        expect(page).to have_css 'form'
      end
    end
  end
end