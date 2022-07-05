class ApplicationController < ActionController::API
  include AuthenticationHelper

  before_action :require_login
end
