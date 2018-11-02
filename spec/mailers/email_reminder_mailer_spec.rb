require "rails_helper"
include ActiveJob::TestHelper

RSpec.describe EmailReminderMailer, type: :mailer do
  before(:each) do
    @user = FactoryBot.create(:user)
    @team = FactoryBot.create(
    :team,
    user_ids: [@user.id],
    has_reminder: true,
    reminder_time: Time.at(
    Time.now.utc.to_i - (Time.now.utc.to_i % 15.minutes)
    ).utc
    )
  end

  it 'job is created' do
    ActiveJob::Base.queue_adapter = :test
    expect do
      EmailReminderMailer.reminder_email(@user,@team).deliver_later
    end.to have_enqueued_job.on_queue('mailers')
  end

  it 'reminder email is sent' do
    expect do
      perform_enqueued_jobs do
        EmailReminderMailer.reminder_email(@user,@team).deliver_later
      end
    end.to change { ActionMailer::Base.deliveries.size }.by(1)
  end

  it 'reminder email is sent to the right user' do
    perform_enqueued_jobs do
      EmailReminderMailer.reminder_email(@user,@team).deliver_later
    end

    mail = ActionMailer::Base.deliveries.last
    expect(mail.to[0]).to eq @user.email
  end
end