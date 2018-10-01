require 'rails_helper'

RSpec.feature "Me", type: :feature do
  login_user

  it 'Should be able to visit my activity and move date forwards' do

    visit activity_mine_path

    click_on(id: 'date_forward')

    expect(current_path).to eql(activity_mine_path)
    expect(page).to have_content(
      (Date.today + 1.day).strftime("%a, %b #{(Date.today + 1.day).day.ordinalize}")
    )
  end

  it 'Should be able to visit my activity and move date backwards' do

    visit activity_mine_path

    click_on(id: 'date_backward')

    expect(current_path).to eql(activity_mine_path)
    expect(page).to have_content(
      (Date.today - 1.day).strftime("%a, %b #{(Date.today - 1.day).day.ordinalize}")
    )
  end

  it 'should visit my activity and move date from picker', js: true do
    visit activity_mine_path

    date_milliseconds = (Time.now.utc.beginning_of_day + 1.day).to_i * 1000

    find('#datePicker').click
    find("td.day[data-date='#{date_milliseconds}']").click

    expect(page).to have_current_path(activity_mine_path)
    expect(page).to have_content(
      (Time.at(date_milliseconds/1000).utc).strftime("%a, %b #{(Time.at(date_milliseconds/1000).utc).day.ordinalize}"
      )
    )
  end
end