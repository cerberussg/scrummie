require 'rails_helper'

RSpec.feature "Edit", type: :feature do
  login_admin

  before(:each) do
    @team = FactoryBot.create(:team, account_id: @admin.account.id)
  end

  context "click and edit the team" do
    it "should click team, edit and go to edit page" do
      visit teams_path
      click_link(id: "team_#{@team.hash_id}_header")
      click_link(id: "edit_#{@team.hash_id}")

      expect(current_path).to eql(edit_team_path(@team))
      expect(page).to have_content("#{@team.name}")
    end

    context "click on the edit page" do
      it "and edit the team successfully" do
        visit teams_path
        click_link(id: "team_#{@team.hash_id}_header")
        click_link(id: "edit_#{@team.hash_id}")

        within "#edit_team_#{@team.id}" do
          fill_in "team_name", with: 'Test'
        end

        click_button("Save")
        expect(page).to have_current_path(teams_path) 
        expect(page).to have_content("Test")
      end

      it "and fail to edit the team successfully" do
        visit teams_path
        click_link(id: "team_#{@team.hash_id}_header")
        click_link(id: "edit_#{@team.hash_id}")

        within "#edit_team_#{@team.id}" do
          fill_in "team_name", with: ''
        end

        click_button("Save")
        expect(page).to have_current_path(team_path(@team))
        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end
