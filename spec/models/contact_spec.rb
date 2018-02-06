require 'rails_helper'

RSpec.describe Contact, type: :model do
  let (:user) { build_stubbed(:user) }
  let (:episode) { build_stubbed(:episode) }
  let (:contact) { build_stubbed(:contact, user: user, episode: episode) }

  describe "a valid contact" do
    it "must have a body" do
      contact.body = nil
      expect(contact).not_to be_valid
    end
  end
end
