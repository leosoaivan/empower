require 'rails_helper'

feature 'Client management' do
  let (:user)   { create(:user) }
  let (:client) { create(:client) }
  let (:alert_danger) { ".flash__alert--danger" }
  let (:alert_success) { ".flash__alert--success" }

  before :each do
    log_in user
  end

  describe "viewing a client" do
    context "without episodes" do
      before :each do
        visit client_path(client)
      end

      it "displays their page" do
        expect(current_path).to eql client_path(client)
      end

      it "displays their demographic info" do
        expect(page).to have_selector(
          "#client-demographic", text: client.firstname)
      end

      it "displays a message indicating a lack of episodes" do
        expect(page).to have_content "There are no episodes"
      end
    end

    context "with one or more episode" do
      let (:respondent) { create(:client) }
      let! (:episode) {
        client.petitioned_episodes.create(
          attributes_for(:episode, respondent_id: respondent.id)
        )
      }

      before :each do
        visit client_path(client)
      end

      it "displays their page" do
        expect(current_path).to eql client_path(client)
      end

      it "displays their demographic info" do
        expect(page).to have_css "#client-demographic"
      end

      it "displays their episodes" do
        expect(page).to have_selector(
          ".card-panel__episode", text: respondent.firstname)
      end

      it "does not display a message indicating a lack of episodes" do
        expect(page).to_not have_content "There are no episodes"
      end
    end
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

      it "does not display the client" do
        expect(page).to_not have_content(client.firstname)
      end
    end

    context "when the client has related episodes" do
      let! (:episode) { create(:episode, petitioner_id: client.id) }
      
      before :each do
        visit client_path(client)
        accept_confirm do
          click_on "Delete client"
        end
      end

      it "flashes a danger message" do
        expect(page).to have_css alert_danger
      end

      it "returns a user to the client page" do
        expect(current_path).to eql client_path(client)
      end

      it "displays the client" do
        expect(page).to have_content(client.firstname)
      end
    end
  end
end