require 'rails_helper'

RSpec.describe Client, type: :model do
  it { is_expected.to have_many(:petitioned_episodes)
    .class_name('Episode')
    .with_foreign_key('petitioner_id')
  }
  it { is_expected.to have_many(:responded_episodes)
    .class_name('Episode')
    .with_foreign_key('respondent_id')
  }
  it { is_expected.to have_many(:respondents).through(:petitioned_episodes) }
  it { is_expected.to have_many(:petitioners).through(:responded_episodes) }
  it { is_expected.to validate_presence_of(:firstname) }
  it { is_expected.to validate_presence_of(:lastname) }

  describe "#all_episodes" do
    it "returns all episodes in which a client is either petitioner or respondent" do
      client = create(:client)
      petitioned_episode = create(:episode, petitioner: client)
      responded_episode = create(:episode, respondent: client)

      all_episodes_ids = client.all_episodes.map(&:id)

      expect(all_episodes_ids).to match_array [1, 2]
    end
  end
end
