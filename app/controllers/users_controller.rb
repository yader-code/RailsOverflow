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
end
