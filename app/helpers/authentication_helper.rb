# frozen_string_literal: true

module AuthenticationHelper
  def require_login
    render status: :unauthorized unless current_user.present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end
end
