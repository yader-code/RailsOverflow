# frozen_string_literal: true

class ApplicationController < ActionController::API
  include AuthenticationHelper

  before_action :require_login
end
