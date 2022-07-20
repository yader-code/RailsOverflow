# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def send_verification_email
    @user = params[:user]
    @url  = api_user_verify_url(token: @user.auth_token)
    mail(to: @user.email, subject: 'Welcome to RailsOverflow')
  end

  def post_creation_notification_email
    emails = params[:emails]
    @post_created = params[:post_created]
    @post_url = api_post_url(id: @post_created.id)
    emails.each do |email|
      @user_mail = email
      mail(to: @user_mail, subject: 'New post was created')
    end
  end
end
