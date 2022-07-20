# frozen_string_literal: true

# config/sidekiq.rb

sidekiq_config = { url: ENV['JOB_WORKER_URL'] }
Sidekiq.configure_server do |config|
  config.redis = sidekiq_config
  config.logger.formatter = Sidekiq::Logger::Formatters::JSON.new

  # Touch a file so we know Sidekiq worker has started.
  # Useful for health checks
  config.on(:startup) do
    FileUtils.touch(Rails.root.join('tmp', 'pids', 'sidekiq_started'))
  end
  # Delete the touched file so we know Sidekiq worker has stopped.
  # Useful for health checks
  config.on(:shutdown) do
    FileUtils.rm(Rails.root.join('tmp', 'pids', 'sidekiq_started'))
  end
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
