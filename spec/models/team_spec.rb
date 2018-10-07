require 'rails_helper'

RSpec.describe Team, type: :model do
  it 'Has a valid facotry' do
    expect(build(:team)).to be_valid
  end

  it { is_expected.to belong_to(:account) }
  it { is_expected.to validate_presence_of(:account) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_presence_of(:timezone) }

  it { is_expected.to have_many(:team_memberships) }
  it { is_expected.to have_many(:users).through(:team_memberships) }

  it { is_expected.to have_many(:days) }
end
