require 'rails_helper'

feature 'Client management' do
  let (:user)   { create(:user) }
  let (:client) { create(:client) }

  before :each do
    log_in(user)
    search_for_client(client.id)
  end

  describe "Editing a client" do
    before :each do
      click_on 'Edit'
    end

    it "redirects to the edit page" do
      expect(current_path).to eql(edit_client_path(client))
    end

    it "shows an edit form" do
      expect(page).to have_css('form')
    end

    context "with valid attributes" do
      before :each do
        fill_in 'firstname', with: "Jack"
        fill_in 'lastname', with: "Black"
        click_on 'Update'
      end

      it "redirects to the client's page" do
        expect(current_path).to eql(client_path(client))
      end

      it "flashes a successful message" do
        expect(page).to have_content("Client successfully edited")
      end

      it "displays the correct attributes" do
        expect(page).to have_content("Jack Black")
      end
    end

    context "with invalid attributes" do
      before :each do
        fill_in 'firstname', with: "Jack"
        fill_in 'lastname', with: ""
        click_button 'Update'
      end
      
      it "shows the edit form" do
        expect(page).to have_css('form')
      end

      it "flashes a danger message" do
        expect(page).to have_content("Invalid edit")
      end
    end
  end
end