require 'rails_helper'
require 'cancan/matchers'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:contacts) }
  it { is_expected.to validate_presence_of(:first_name) }
  it { is_expected.to validate_presence_of(:last_name) }  
  it { is_expected.to validate_presence_of(:username) }
  it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).case_insensitive }
  it { is_expected.to validate_length_of(:password).is_at_least(6) }

  describe "abilities" do
    subject (:ability) { Ability.new(user) }
    let (:can_user)     { FactoryBot.build_stubbed(:user) }                 
    let (:can_client)   { FactoryBot.build_stubbed(:client) }
    let (:can_episode)  { FactoryBot.build_stubbed(:episode) }
    let (:can_contact)  { FactoryBot.build_stubbed(:contact) }
    
    context "when user is an admin" do
      let (:user) { FactoryBot.create(:admin) }
      it { is_expected.to be_able_to(:manage, can_user) }
      it { is_expected.to be_able_to(:manage, can_client) }
      it { is_expected.to be_able_to(:manage, can_episode) }
      it { is_expected.to be_able_to(:manage, can_contact) }
    end

    context "when user is a staff" do
      let (:user) { FactoryBot.create(:staff) }
      it { is_expected.not_to be_able_to(:manage, can_user) }
      it { is_expected.to be_able_to(:manage, can_client) }
      it { is_expected.to be_able_to(:manage, can_episode) }
      it { is_expected.to be_able_to(:manage, can_contact) }
    end

    context "when user is a guest" do
      let (:user) { FactoryBot.create(:guest) }
      it { is_expected.not_to be_able_to(:manage, can_user) }
      it { is_expected.not_to be_able_to(:manage, can_client) }
      it { is_expected.not_to be_able_to(:manage, can_episode) }
      it { is_expected.not_to be_able_to(:manage, can_contact) }
    end
  end
end
