require 'rails_helper'

RSpec.describe ClientDecorator do
  subject(:client_decorator) { ClientDecorator.new(client) }
  let(:client) { 
    build_stubbed(
      :client, 
      first_name: 'Jack', 
      last_name: 'Black',
      dob: '1984-04-18')
  }

  describe '#fullname' do
    it 'returns the client\'s full name' do
      expect(client_decorator.fullname).to eql 'Jack Black'
    end
  end

  describe '#mmddyyyy' do
    it 'returns the client\'s DOB in mm/dd/yyyy format' do
      expect(client_decorator.mmddyyyy).to eql '04/18/1984'
    end
  end
end
