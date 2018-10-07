require 'rails_helper'

RSpec.feature "Teams", type: :feature do
  login_admin

  before(:each) do
    @team = FactoryBot.create(:team, account_id: @admin.account.id)
  end

  it "should be able to visit the team index and see at least one team" do
    visit teams_path

    expect(current_path).to eql(teams_path)
    expect(page).to have_content("Teams")
    expect(page).to have_content("#{@team.name}")
  end

  it "should click on team and see show page" do
    visit teams_path
    click_link(id: "team_#{@team.hash_id}_header")

    expect(current_path).to eql(team_path(@team))
    expect(page).to have_content("#{@team.name}")
  end
end
