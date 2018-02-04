require 'rails_helper'

RSpec.describe ClientDecorator do
  subject(:client_decorator) { ClientDecorator.new(client) }
  let(:client) { 
    build_stubbed(:client, firstname: 'Jack', lastname: 'Black')
  }

  describe '#fullname' do
    it 'returns the full name of a client' do
      expect(client_decorator.fullname).to eql 'Jack Black'
    end
  end
end
