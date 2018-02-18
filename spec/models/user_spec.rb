require 'rails_helper'

RSpec.describe User, type: :model do
  let (:user) { create(:user, name: "Triss Merigold") }
  
  describe "a valid Factory" do
    it "creates a username" do
      expect(user.username).to eq("tmerigold")
    end

    it "creates an email" do
      expect(user.email).to eq("tmerigold@empower.org")
    end
  end

  describe "a valid User" do
    it "requires a non-blank name" do
      user.name = nil
      expect(user).to_not be_valid
    end

    it "requires a non-blank username" do
      user.username = nil
      expect(user).to_not be_valid
    end

    it "requires a unique username" do
      user
      duplicate_user = build(:user, username: "tmerigold")
      expect(duplicate_user).to_not be_valid
    end

    it "requires a non-blank email" do
      user.email = nil
      expect(user).to_not be_valid
    end

    it "requires a unique email" do
      user
      duplicate_user = build(:user, email: "tmerigold@empower.org")
      expect(duplicate_user).to_not be_valid
    end

    it "requires a non-blank password" do
      user.password = nil
      expect(user).to_not be_valid
    end

    it "requires a minimum length password" do
      user.password = "a" * 5
      expect(user).to_not be_valid
    end
  end
end
