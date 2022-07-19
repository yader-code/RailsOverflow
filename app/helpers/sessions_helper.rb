# frozen_string_literal: true

module SessionsHelper
  def login(user)
    session ||= self
    session.post api_login_url, params: { email: user.email, password: user.password }
  end
end
