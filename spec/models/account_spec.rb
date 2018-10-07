require 'rails_helper'

RSpec.describe Account, type: :model do
  context  'Valid factory' do
    it 'Has a valid factory' do
      expect(FactoryBot.build(:account)).to be_valid
    end
  end

  it { is_expected.to validate_presence_of(:name) }
end
