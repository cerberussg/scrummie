require 'rails_helper'

describe NotificationServices::SlackWebhooks do

  describe 'the SlackWebhooks service object' do
    context 'from form input' do
      let(:account)    { build(:account) }
      let(:user)       { build(:user) }

      it 'responds to send_message' do
        expect_any_instance_of(
          NotificationServices::SlackWebhooks
        ).to receive(:send_message).once
        NotificationServices::SlackWebhooks::NewAccount
        .(account: account, user: user)
      end
    end
  end
end