require 'rails_helper'

feature "Contacts management" do
  let (:user) { create(:user) }
  let (:client) { create(:client) }
  let! (:episode) { create(:episode, petitioner_id: client.id) }
  let (:alert_danger) { ".flash__alert--danger" }
  let (:alert_success) { ".flash__alert--success" }
  
  before :each do
    log_in user
    visit client_path(client)
    click_on "View episode"
  end
  
  describe "creating a contact" do
    before :each do
      click_on "Create contact"
    end

    it "displays a form" do
      expect(page).to have_css "form"
    end
    
    context "with a valid body" do
      before :each do
        fill_in "Body", with: "This is a contact body."
        click_on "Create Contact"
      end

      it "displays a successful message" do
        expect(page).to have_css alert_success
      end

      it "redirects a user back to the episode" do
        expect(current_path).to eql client_episode_path(client, episode)
      end

      it "displays the newly added contact" do
        expect(page).to have_content "This is a contact body."
      end
    end

    context "with an invalid body" do
      before :each do
        fill_in "Body", with: ""
        click_on "Create Contact"
      end

      it "flashes a danger message" do
        expect(page).to have_css alert_danger
      end

      it "returns the form" do
        expect(page).to have_css "form"
      end
    end
  end
end

