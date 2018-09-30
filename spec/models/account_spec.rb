require 'rails_helper'

RSpec.describe Account, type: :model do
  context  'Valid factory' do
    it 'Has a valid factory' do
      expect(FactoryBot.build(:account)).to be_valid
    end
  end

  context 'Valid validation' do
    it 'Will not save without a name' do
      expect(FactoryBot.build(:account, name: nil).save).to be_falsey
    end
  end
end
