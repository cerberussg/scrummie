require 'rails_helper'

describe NewRegistrationService do
  subject(:registration_service) { NewRegistrationService }

  describe 'create an accounts' do
    context 'from form input' do
      let(:account)       { build(:account) }
      let(:bad_account)   { build(:account, {name: nil}) }
      let(:user)          { build(:user) }

      it 'create an account' do
        expect{
          registration_service.(account: account, user: user)
        }.to change(Account, :count).by(1)
      end

      it 'does not create an account on invalid object' do
        expect{
          registration_service.(account: bad_account, user: user)
        }.to change(Account, :count).by(0)
      end

      it 'creates a user' do
        expect{
          registration_service.(account: account, user: user)
        }.to change(User, :count).by(1)
      end

      it 'sends a message to be passed to welcome email method' do
        expect_any_instance_of(
          NewRegistrationService
        ).to receive(:send_welcome_email).once
        registration_service.(account: account, user: user)
      end

      it 'sends a message to be passed to slack method' do
        expect_any_instance_of(
          NewRegistrationService
        ).to receive(:notify_slack).once
        registration_service.(account: account, user: user)
      end
    end
  end
end