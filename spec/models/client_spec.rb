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

  describe '#all_episodes' do
    it 'returns all episodes in which a client is either petitioner or respondent' do
      client = create(:client)
      petitioned_episode = create(:episode, petitioner: client)
      responded_episode = create(:episode, respondent: client)

      all_episodes_ids = client.all_episodes.map(&:id)

      expect(all_episodes_ids).to match_array [1, 2]
    end
  end

  describe '.chain_scopes_for_searching' do
    let! (:client_1) { FactoryBot.create(:client, firstname: 'Abe') }
    let! (:client_2) { FactoryBot.create(:client, firstname: 'Becky') }
    let! (:client_3) { FactoryBot.create(:client, firstname: 'Becky', lastname: 'Law') }

    it 'sends at least one valid scope/method' do
      scopes = { 
        "where_firstname_like" => client_2.firstname        
      }

      expect(Client.chain_scopes_for_searching(scopes)).to match_array [client_2, client_3]
    end

    it 'sends two or more scopes/methods' do
      scopes = {
        "where_id" => client_2.id,
        "where_firstname_like" => client_2.firstname
      }

      expect(Client.chain_scopes_for_searching(scopes)).to match_array [client_2]
    end

    it 'ignores 1+ empty scopes' do
      scopes = { 
        "where_id" => client_1.id,
        "where_firstname_like" => ""
      }

      expect(Client.chain_scopes_for_searching(scopes)).to match_array [client_1]
    end

    it 'ignores all empty scopes' do
      scopes = {
        "where_id" => ""
      }

      expect(Client.chain_scopes_for_searching(scopes)).to match_array Client.all
    end
  end
end
