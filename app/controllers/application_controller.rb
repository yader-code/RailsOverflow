class ApplicationController < ActionController::API
  include AuthenticationHelper

  before_action :require_login?, except: %i[sessions_create, sessions_destroy, sessions_signup]
end
