require 'rails_helper'

RSpec.describe Service, type: :model do
  let (:service) { build_stubbed(:service) }

  it { is_expected.to belong_to(:service_type) }
  it { is_expected.to have_and_belong_to_many(:contacts) }

  describe 'a valid contact' do
    it 'must have a name' do
      service.name = nil
      expect(service).not_to be_valid 
    end
  end
end
