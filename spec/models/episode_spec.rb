require 'rails_helper'

RSpec.describe Episode, type: :model do
  it { is_expected.to belong_to(:petitioner).class_name('Client') }
  it { is_expected.to belong_to(:respondent).class_name('Client') }
  it { is_expected.to accept_nested_attributes_for(:respondent) }
  it { is_expected.to validate_presence_of(:relationship) }
  it { is_expected.to validate_presence_of(:victimization) }
  it { is_expected.to have_many(:contacts).order(created_at: :desc).dependent(:destroy) }
end
