require 'rails_helper'

RSpec.describe Client, type: :model do
  describe "#all_episodes" do
    it "returns all episodes in which a client is either petitioner or respondent" do
      client = create(:client)
      other_client = create(:client)
      episode1 = create(:episode, petitioner_id: client.id, respondent_id: other_client.id)
      episode2 = create(:episode, petitioner_id: other_client.id, respondent_id: client.id)
      expect(client.all_episodes).to include(episode1, episode2)
    end
  end

  describe ".search(params)" do
    let (:client) { create(:client, firstname: "Kevin", lastname: "Smith") }
    let (:params) { params = { 
      firstname: client.firstname,
      lastname: client.lastname 
      }
    }

    it "returns a user if there is a firstname match" do
      params = { firstname: client.firstname, lastname: "" }
      expect(Client.search(params)).to include(client)
    end

    it "returns a user if there is a last match" do
      params = { firstname: "", lastname: client.lastname }
      expect(Client.search(params)).to include(client)
    end

    it "returns a user if there is a full name match" do
      expect(Client.search(params)).to include(client)
    end
  end
end
