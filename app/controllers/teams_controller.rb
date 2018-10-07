class TeamsController < ApplicationController
  load_and_authorize_resource find_by: :hash_id, except:[:create]
  around_action :use_time_zone, only: [:edit]

  def index
    @teams = visible_teams
  end

  def show
    @team = Team.friendly.includes(:users).find(params[:id])
  end

  def new
    @team = Team.new
    set_users
  end

  def create
    @team = Team.new(team_params.except("days"))
    @team.account_id = current_account.id
    @team.days = days_of_the_week
    convert_zone_times_to_utc
    authorize!(:create, @team)

    if @team.save
      @teammembership = TeamMembership.create!(team_id: @team.id, user_id: current_user.id)
      if @teammembership.save
        redirect_to @team, notice: "Team was successfully created"
      else
        set_users
        render :new
      end
    else
      set_users
      render :new
    end
  end

  def edit
    @team = Team.friendly.find(params[:id])
    # convert_from_utc
    set_users
  end

  def update
    @team = Team.friendly.find(params[:id])
    @team.attributes = team_params.except('days')
    @team.days = days_of_the_week
    convert_zone_times_to_utc

    if @team.save
      redirect_to @team, notice: "Team was successfully updated"
    else
      render :edit
    end
  end

  def destroy
    @team = Team.friendly.find(params[:id])
    @team.destroy
    redirect_to teams_url, notice: 'Team was successfully deleted'
  end

  private

  def team_params
    params.require(:team).permit(:name, :description, :timezone, :has_reminder, :has_recap, :reminder_time, :recap_time, :days_of_the_week=> [])
  end

  def set_users
    @account_users ||=
    current_account.users.where.not(invitation_accepted_at: nil) +
    current_account.users.with_role(:admin, current_account).distinct
  end

  def days_of_the_week
    params[:team][:days_of_the_week]
    &.map do |day|
      DaysOfTheWeekMembership.new(
        team_id: @team_id,
        day: day
      )
    end || []
  end

  def use_time_zone(&block)
    Time.use_zone(@team.timezone, &block)
  end

  def convert_zone_times_to_utc
    convert_reminder
    convert_recap
  end

  def convert_reminder
    return nil unless @team.reminder_time && @team.has_reminder
    @team.reminder_time =
      ActiveSupport::TimeZone[@team.timezone]
      .parse(@team.reminder_time.to_s[11..18])
      .utc
  end

  def convert_recap
    return nil unless @team.recap_time && @team.has_recap
    @team.recap_time =
      ActiveSupport::TimeZone[@team.timezone]
      .parse(@team.recap_time.to_s[11..18])
      .utc
  end
end