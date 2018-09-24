require 'rails_helper'

RSpec.describe FollowUp, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to belong_to(:episode) }
  it { is_expected.to validate_presence_of(:due_by_date) }
  it { is_expected.to validate_presence_of(:due_by_shift) }
  it { is_expected.to define_enum_for(:due_by_shift) }
end
