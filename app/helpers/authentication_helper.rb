module AuthenticationHelper

  def logged_in?
    render status: :unauthorized unless session[:user_id].present?
  end

  def current_user
    @current_user = User.find_by(id: session[:user_id])
  end
end
