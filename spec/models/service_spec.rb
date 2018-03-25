require 'rails_helper'

RSpec.describe Service, type: :model do
  it { is_expected.to belong_to(:service_type) }
  it { is_expected.to have_and_belong_to_many(:contacts) }
  it { is_expected.to validate_presence_of(:name) }
end
