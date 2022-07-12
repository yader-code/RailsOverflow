class UsersController < ApplicationController

  def update
  end

  def destroy
  end

  def show
    if current_user.nil?
      render status: :unauthorized
    else
      render json: @current_user, status: :ok
    end
  end

  def verify
    user = User.find_by_auth_token(user_token[:token])
    if user.present? && user.verified.nil?
      user.update(verified: true, verification_date: DateTime.now)
      return
    end

    return render status: :unauthorized
  end

  private
  def user_token
    params.permit(:token)
  end
end
