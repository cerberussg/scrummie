require 'rails_helper'

RSpec.describe Blocker, type: :model do
  it 'Has a valid factory' do
    expect(FactoryBot.build(:task, type: "Blocker")).to be_valid
  end
end