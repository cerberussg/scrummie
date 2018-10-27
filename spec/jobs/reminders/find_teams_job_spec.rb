require 'rails_helper'
include ActiveJob::TestHelper

RSpec.describe Reminders::FindTeamsJob do
  it 'matches with enqueued job' do
    ActiveJob::Base.queue_adapter = :test
    Reminders::FindTeamsJob.perform_later
    expect(Reminders::FindTeamsJob).to have_been_enqueued
  end


  context 'finding teams for reminders' do
    before(:each) do
      ActiveJob::Base.queue_adapter = :test
      @team = FactoryBot.create(
        :team,
        has_reminder: true,
        reminder_time: Time.at(
          Time.now.utc.to_i - (Time.now.utc.to_i % 15.minutes)
        ).utc
      )
      @team.update(
        days: [DaysOfTheWeekMembership.new(
          team_id: @team.id,
          day: Time.now.utc.strftime('%A').downcase
        )]
      )
    end
    it 'finds a team with reminders' do
      job = Reminders::FindTeamsJob.new
      expect(Reminders::EmailUserOnTeamJob)
        .to receive(:perform_later).with(@team)
      job.perform_now
    end
  end
end
