class EmailRecapMailer < ApplicationMailer
  default from: "'Scrummie' <scrummie@scrummie.app>"

  def recap_email(user, team, standups)
    @user = user
    @team = team
    @standups = standups

    mail(to: @user.email, subject: "#{team.name} Standups Recap!")
  end
end