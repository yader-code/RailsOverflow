# frozen_string_literal: true

class ApiController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :not_found_exception

  def not_found_exception
    render status: :not_found
  end
end
