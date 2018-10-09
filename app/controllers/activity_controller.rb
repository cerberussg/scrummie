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
  end

  def feed
  end
end
