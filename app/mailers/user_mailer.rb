# frozen_string_literal: true

class UserMailer < ApplicationMailer
  default from: 'notifications@example.com'

  def send_verification_email
    @user = params[:user]
    @url  = api_user_verify_url(token: @user.auth_token)
    mail(to: @user.email, subject: 'Welcome to RailsOverflow')
  end

  def post_creation_notification_email
    @post_created = params[:post_created]

    emails = get_users_emails(@post_created)

    @post_url = api_post_url(id: @post_created.id)

    emails.each do |email|
      @user_mail = email
      mail(to: @user_mail, subject: 'New post was created')
    end
  end

  private

  def get_users_emails(post_created)
    Post.find(post_created.post_id).posts.joins(:user).distinct
        .where.not(users: { id: post_created.user_id }).pluck(:email)
  end
end
