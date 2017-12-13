require 'rails_helper'

RSpec.describe Episode, type: :model do
  let (:petitioner) { create(:client) }
  let (:respondent) { create(:client) }
  let (:episode) { create(:episode, petitioner_id: petitioner.id) }

  describe "a valid episode" do
    it 'requires a valid client as petitioner' do
      episode.petitioner = nil
      expect(episode).to_not be_valid
    end

    it "requires one relationship type" do
      episode.relationship = " "
      expect(episode).to_not be_valid
    end

    it "allows more than one relationship type" do
      episode.relationship = ["dating/sexual/romantic", "shared residence"]
      expect(episode).to be_valid
    end

    it "requires one victimization type" do
      episode.victimization = " "
      expect(episode).to_not be_valid
    end

    it "allows more than one relationship type" do
      episode.relationship = ["intimate partner violence", "sexual assault"]
      expect(episode).to be_valid
    end

  end

end
