require 'rails_helper'

RSpec.describe Todo, type: :model do
  it 'Has a valid factory' do
    expect(FactoryBot.build(:task, type: "Todo")).to be_valid
  end
end