module AuthenticationHelper

  def require_login?
    session[:user_id].present?
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if require_login?
  end
end
