require 'rails_helper'

RSpec.describe ServiceType, type: :model do
  let (:service_type) { build_stubbed(:service_type) }

  it { is_expected.to have_many(:services) }

  describe 'a valid contact' do
    it 'must have a name' do
      service_type.name = nil
      expect(service_type).not_to be_valid 
    end
  end
end
