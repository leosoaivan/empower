require 'rails_helper'

RSpec.describe Contact, type: :model do
  let (:user) { build_stubbed(:user) }
  let (:episode) { build_stubbed(:episode) }
  let (:contact) { build_stubbed(:contact, user: user, episode: episode) }

  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:episode) }
  it { is_expected.to have_and_belong_to_many(:services) }

  describe 'a valid contact' do
    it 'must have a body' do
      contact.body = nil
      expect(contact).not_to be_valid
    end
  end
end
