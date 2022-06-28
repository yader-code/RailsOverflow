class UsersController < ApplicationController
  include AuthenticationHelper

  def update
  end

  def destroy
  end

  def show
    if logged_in?
      render json: current_user, status: :ok
    else
      render status: :unauthorized
    end
  end
end
