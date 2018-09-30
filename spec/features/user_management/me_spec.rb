require 'rails_helper'

RSpec.feature "Me", type: :feature do
  login_user

  it "should be able to visit my_settings" do
    visit my_settings_path

    expect(current_path).to eql(my_settings_path)
  end

  it "should edit my settings successfully" do
    visit my_settings_path

    within "#edit_user_#{@user.id}" do
      fill_in "user_name", with: 'Test'
      fill_in "user_email", with: 'test@test.com'
    end

    click_button("Update My Settings")
    expect(current_path).to eql(my_settings_path)
  end

  it "and fail to edit my settings successfully" do
    visit my_settings_path

    within "#edit_user_#{@user.id}" do
      fill_in "user_name", with: 'Test'
      fill_in "user_email", with: ''
    end

    click_button("Update My Settings")
    expect(current_path).to eql(update_my_settings_path)
    expect(page).to have_content("error")
  end
end
