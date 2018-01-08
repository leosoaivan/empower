require 'rails_helper'

feature "Managing episodes" do
  let (:client) { create(:client) }
  let (:id) { "episode_relationship[Now or previously married]" }

  describe "creating an episode" do
    before :each do
      log_in create(:user)
      visit client_path(client)
      click_on "btn__new-client-episode"
    end

    it "displays a form" do
      expect(page).to have_css('form')
    end

    xit "displays active unchecked fields" do
      expect(page).to have_unchecked_field(id, visible: true)
    end

    context "with valid attributes" do
      before :each do
        check 'episode_relationship[Now or previously married]'
        check 'episode_victimization[Intimate partner violence]'
        click_on "Create Episode"
      end

      it "flashes a successful message" do
        expect(page).to have_css '.flash__alert--success'
      end

      it "redirects back to the client's page" do
        expect(current_path).to eql client_path(client)
      end

      it "displays the new episode" do
        expect(page).to have_css '.card-panel__episode'
      end
    end

    context "with invalid attributes" do
      before :each do
        click_on "Create Episode"
      end

      it "flashes a danger message" do
        expect(page).to have_css ".flash__alert--danger"
      end

      it "returns the form" do
        expect(page).to have_css "form"
      end

      xit "keeps the checkboxes active" do
        expect(page).to have_unchecked_field(id, visible: true)
      end
    end
  end
end