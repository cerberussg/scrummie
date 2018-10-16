class ActivityController < ApplicationController
  authorize_resource :class => "ActivityController"

  def mine
    @standups =
      current_user
      .standups
      .includes(:dids, :todos, :blockers)
      .references(:tasks)
      .order('standup_date DESC')
      .page(params[:page])
      .per(6)


    @teams =
      current_user
      .teams
      .includes(:days)
      .where(has_reminder: true)
      .where('days_of_the_week_memberships.day = ?', current_day)
      .references(:days_of_the_week_memberships)
  end

  def feed
  end

  private

    def current_day
      DaysOfTheWeekMembership.days[Time.now.utc.strftime('%A').downcase.to_sym]
    end
end
