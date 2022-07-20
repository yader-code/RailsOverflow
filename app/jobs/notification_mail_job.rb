# frozen_string_literal: true

class NotificationMailJob < ApplicationJob
  queue_as :mailers

  def perform(*args)
    # Do something later
  end
end
