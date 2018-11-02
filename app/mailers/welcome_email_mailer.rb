class WelcomeEmailMailer < ApplicationMailer
  default from: "'Scrummie' <welcome@scrummie.app>"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: "Welcome to Scrummie, #{user.name}!!")
  end
end
