class SlackNotificationJob < ApplicationJob
  queue_as :notifications

  def perform(user)
    notifier = Slack::Notifier.new(
      'https://hooks.slack.com/services/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'
    )
    notifier.ping "A New User has appeared! #{user.account.name} - #{user.name} || ENV: #{Rails.env}"
  end
end
