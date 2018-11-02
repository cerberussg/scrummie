require 'rails_helper'
include ActiveJob::TestHelper
ActiveJob::Base.queue_adapter = :test

RSpec.feature "SignUpProcesses", type: :feature do
  it "should require the user to sign up and successfully sign up" do

    visit root_path

    click_on 'Sign up'

    within "#new_user" do
      fill_in "user_name", with: 'Best'
      fill_in "user_email", with: 'test@test.com'
      fill_in "user_password", with: 'password123'
      fill_in "user_password_confirmation", with: 'password123'
    end

    click_button "Sign Up"

    expect(current_path).to eql(new_accounts_path)

    within "#new_account" do
      fill_in "account_name", with: "Test Co"
    end

    expect do
      click_button "Save"
      expect(ActionMailer::Base.deliveries.last.to).to eq ["test@test.com"]
      expect(current_path).to eql(root_path)
    end
  end

  it "should fail on an invalid user information" do

    visit root_path

    click_on 'Sign up'

    within "#new_user" do
      fill_in "user_name", with: 'Test'
      fill_in "user_email", with: 'test'
      fill_in "user_password", with: 'p'
    end

    click_button "Sign Up"

    expect(current_path).to eql('/users')
    expect(page).to have_content("error")
  end

  it "should fail on an invalid account information" do

    visit root_path

    click_on 'Sign up'

    within "#new_user" do
      fill_in "user_name", with: 'Test'
      fill_in "user_email", with: 'test2@test.com'
      fill_in "user_password", with: 'password123'
      fill_in "user_password_confirmation", with: 'password123'
    end

    click_button "Sign Up"

    within "#new_account" do
      fill_in "account_name", with: ""
    end

    click_button "Save"
    expect(current_path).to eql('/accounts')
    expect(page).to have_content("error prohibited this account from being saved")
  end
end
