require 'rails_helper'

feature 'Client management' do
  let (:user)   { create(:user) }
  let (:client) { create(:client) }
  let (:client_with_episodes) { create(:client_with_episodes) }
  let (:alert_danger) { ".flash__alert--danger" }
  let (:alert_success) { ".flash__alert--success" }

  before :each do
    log_in user
  end
  
  describe "editing a client" do
    before :each do
      search_for_client client.id
      click_on 'Edit'
    end

    it "displays an edit form" do
      expect(page).to have_css "form"
    end

    context "with valid attributes" do
      before :each do
        fill_in "client[firstname]", with: "Jack"
        fill_in "client[lastname]", with: "Black"
        click_on 'Edit Client'
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
        fill_in "client[firstname]", with: "Jack"
        fill_in "client[lastname]", with: ""
        click_button 'Edit Client'
      end
      
      it "flashes a danger message" do
        expect(page).to have_css alert_danger
      end

      it "returns the edit form" do
        expect(page).to have_css 'form'
      end
    end
  end

  describe "creating a client" do
    before :each do
      visit new_client_path
    end
    
    it "displays a create form" do
      expect(page).to have_css "form"
    end

    context "with valid attributes" do
      before :each do
        fill_in "client[firstname]", with: "Joe"
        fill_in "client[lastname]", with: "Black"
        click_on 'Create Client'
      end

      it "flashes a successful message" do
        expect(page).to have_css alert_success
      end

      it "redirects back to a client's page" do
        expect(current_path).to eql client_path(Client.last)
      end

      it "displays a client's attributes" do
        expect(page).to have_content "Joe Black"
      end
    end

    context "with invalid attributes" do
      before :each do
        fill_in "client[firstname]", with: "Joe"
        fill_in "client[lastname]", with: ""
        click_on 'Create Client'
      end

      it "flashes a danger message" do
        expect(page).to have_css alert_danger
      end

      it "returns the create form" do
        expect(page).to have_css "form"
      end
    end
  end

  describe "deleting a client", js: true do
    context "when the client has no related episodes" do
      before :each do
        visit client_path client
        accept_confirm do
          click_on "Delete"
        end
      end

      it "flashes a successful message" do
        expect(page).to have_css alert_success
      end
      
      it "redirects back to the clients search page" do
        expect(current_path).to eql clients_path
      end
    end

    context "when the client has related episodes" do
      before :each do
        visit client_path client_with_episodes
        accept_confirm do
          click_on "Delete"
        end
      end

      it "flashes a danger message" do
        expect(page).to have_css alert_danger
      end

      it "returns the client page" do
        expect(current_path).to eql client_path client_with_episodes
      end
    end
  end
end