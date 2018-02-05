require 'rails_helper'

RSpec.describe Client, type: :model do
  let (:client) { build_stubbed(:client) }

  describe "a valid client" do
    it "must have a firstname" do
      client.firstname = nil
      expect(client).to_not be_valid
    end

    it "must have a lastname" do
      client.lastname = nil
      expect(client).to_not be_valid
    end
  end

  describe "#all_episodes" do
    it "returns all episodes in which a client is either petitioner or respondent" do
      client = create(:client)
      other_client = create(:client)
      episode1 = create(:episode, petitioner_id: client.id, respondent_id: other_client.id)
      episode2 = create(:episode, petitioner_id: other_client.id, respondent_id: client.id)
      expect(client.all_episodes).to include(episode1, episode2)
    end
  end
end
