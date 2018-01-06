require 'rails_helper'

feature "Creating contacts" do
  let (:user) { create(:user) }
  let (:client) { create(:client_with_episodes) }
  let (:episode) { client.all_episodes.first }

  describe "creating a contact" do
    before :each do
      log_in user
      visit episode_path(episode)
    end
    
    it "displays a form" do
    end

    context "with a valid body" do
      it "flashes a successful message" do
      end

      it "redirects a user back to the episode" do
      end

      it "displays a newly added contact" do
      end
    end

    context "with an invalid body" do
      it "flashes a danger message" do
      end

      it "returns the form" do
      end
    end
  end
end

