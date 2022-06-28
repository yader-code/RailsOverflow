class SessionsController < ApplicationController
  def create
    user = User.find_by_email(params[:email])

    if user&.authenticate(params[:password])
      old_values = session.to_hash
      reset_session
      session.update old_values.except('session_id')
      session[:user_id] = user.id
      render status: :ok
    else
      render status: :unauthorized
    end
  end

  def destroy
    session.delete(:user_id)
    render status: :no_content
  end

  def singup

    if User.find_by_email(params[:email]).nil?
      user = User.create(name: params[:name], email: params[:email], keywords: params[:keywords],
                         password: params[:password])

      if user.save
        render status: :created
      else
        render json: user.errors, status: :bad_request
      end

    else
      render json: { "error": "the email #{params[:email]} already exists" }, status: :conflict
    end

  end
end
