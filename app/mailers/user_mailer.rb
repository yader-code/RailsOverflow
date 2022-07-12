class UserMailer < ApplicationMailer

  default from: 'notifications@example.com'

  def send_verification_email
    @user = params[:user]
    @url  = user_verify_url(token: @user.auth_token)
    mail(to: @user.email, subject: 'Welcome to RailsOverflow')
  end
end
