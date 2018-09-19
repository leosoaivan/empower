require 'rails_helper'

RSpec.describe ClientDecorator do
  subject(:client_decorator) { ClientDecorator.new(client) }
  let(:client) { build_stubbed(:client, attributes_for(:client)) } 

  describe '#fullname' do
    it 'returns the client\'s full name' do
      expect(client_decorator.fullname).to eql(client.first_name + " " + client.last_name)
    end
  end

  describe '#mmddyyyy' do
    it 'returns the client\'s DOB in mm/dd/yyyy format' do
      expect(client_decorator.mmddyyyy).to match(/(\d{2}\/){2}\d{4}/)
    end
  end
end
