require 'rails_helper'

describe NotificationServices::SlackWebhooks::NewAccount do

  describe 'the SlackWebhooks::NewAccount service object' do
    context 'from form input' do
      let(:account)     { build(:account) }
      let(:user)        { build(:user) }

      it 'responds has the correct message' do
        expect(
          NotificationServices::SlackWebhooks::NewAccount.new(account: account, user: user).send(:message)
        ).to eq("A New User has appeared! #{account.name} - #{user.name} || ENV: #{Rails.env}")
      end

      it 'responds to send_message' do
        expect_any_instance_of(
          NotificationServices::SlackWebhooks::NewAccount
        ).to receive(:send_message).once
        NotificationServices::SlackWebhooks::NewAccount
        .(account: account, user: user)
      end
    end
  end
end