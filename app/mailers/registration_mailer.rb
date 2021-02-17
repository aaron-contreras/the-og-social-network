class RegistrationMailer < ApplicationMailer
  default from: 'cosmossocialnetwork@example.com'

  def welcome_email
    @user = params[:user]
    @profile_url = params[:profile_url]

    mail(to: @user.email, subject: 'Welcome to The Cosmos Social Network')
  end
end
