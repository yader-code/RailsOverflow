require_relative '../mailers/user_mailer'

class SessionsController < ApplicationController

  skip_before_action :require_login, only: %i[create signup]

  def create
    user = User.find_by_email(login_params[:email])

    if user&.authenticate(login_params[:password]) && user.verified
      reset_session
      session[:user_id] = user.id
      render status: :ok
    else
      render status: :unauthorized
    end
  end

  def destroy
    reset_session
    render status: :no_content
  end

  def signup

    @user = User.create(signup_params)

    if @user.errors.present?
      render json: @user.errors, status: :bad_request
    else
      UserMailer.with(user: @user).send_verification_email.deliver_later
      render status: :created
    end
  end

  private

  def login_params
    params.permit(:email, :password)
  end

  def signup_params
    params.permit(:email, :password, :name, keywords: [])
  end

end
