require 'rails_helper'

RSpec.feature "New", type: :feature do
  login_admin

  context "click and new the team" do
    it "should click new and go to new page" do
      visit teams_path
      click_link(id: 'new_team')

      expect(current_path).to eql(new_team_path)
    end

    context "and on the new page" do
      it "and new the team successfully" do
        visit teams_path
        click_link(id: 'new_team')

        within "#new_team" do
          fill_in "team_name", with: 'Test'
        end

        click_button("Save")
        expect(page).to have_current_path(team_path(Team.last)) 
        expect(page).to have_content("#{Team.last.name}")
      end

      it "and fail to new the team successfully" do
        visit teams_path
        click_link(id: 'new_team')

        within "#new_team" do
          fill_in "team_name", with: ''
        end

        click_button("Save")
        expect(page).to have_current_path(teams_path)
        expect(page).to have_content("Name can't be blank")
      end
    end
  end
end
