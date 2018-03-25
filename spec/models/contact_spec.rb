require 'rails_helper'

RSpec.describe Contact, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:episode) }
  it { is_expected.to have_and_belong_to_many(:services) }
  it { is_expected.to validate_presence_of(:body) }
end
