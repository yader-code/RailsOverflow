class UsersController < ApplicationController
  include AuthenticationHelper

  before_action :logged_in?, only: %i[show destroy update]
  def update
  end

  def destroy
  end

  def show
    render json: current_user, status: :ok
  end
end
