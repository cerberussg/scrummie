require 'rails_helper'

RSpec.describe Standup, type: :model do
  it 'Has a valid factory' do
    expect(FactoryBot.build(:standup)).to be_valid
  end

  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_presence_of(:user) }

  it { is_expected.to have_many(:task_memberships) }
  it { is_expected.to have_many(:tasks).through(:task_memberships) }

  it { is_expected.to have_many(:did).through(:task_memberships) }
  it { is_expected.to have_many(:todos).through(:task_memberships) }
  it { is_expected.to have_many(:blockers).through(:task_memberships) }
end
