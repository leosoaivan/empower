require 'rails_helper'

RSpec.describe Contact, type: :model do
  let (:user) { create(:user) }
  let (:petitioner) { create(:client) }
  let (:episode) { create(:episode, petitioner_id: petitioner.id) }
  let (:contact) { create(:contact, user: user, episode: episode) }

  describe "a valid contact" do
    it "must have a body" do
      contact.body = nil
      expect(contact).to_not be_valid
    end
  end
end
