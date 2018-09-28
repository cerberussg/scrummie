require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Valid factory' do
    it 'Has a valid factory' do
      expect(FactoryBot.build(:user)).to be_valid
    end
  end
end
