require 'rails_helper'

RSpec.describe ContactDecorator do
  subject(:contact_decorator) { ContactDecorator.new(contact) }
  let (:datetime) { DateTime.parse('2018-02-19 4:56pm') }
  let (:contact) { build_stubbed(:contact, created_at: datetime) }

  describe '#date_and_time' do
    it 'returns the contact time in mm/dd/yy h:mm am/pm format' do
      expect(contact_decorator.date_and_time).to eql '02/19/18 at 4:56pm'
    end
  end
end