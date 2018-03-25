require 'rails_helper'

RSpec.describe ServiceType, type: :model do
  it { is_expected.to have_many(:services) }
  it { is_expected.to validate_presence_of(:name) }
end
