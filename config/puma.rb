workers Integer(ENV['WEB_CONCURRENCY'] || Settings.workers)
threads_count = Integer(ENV['MAX_THREADS'] || Settings.threads)
threads threads_count, threads_count

preload_app!

rackup      DefaultRackup
port        ENV['PORT']     || Settings.port
environment ENV['RACK_ENV'] || Settings.environment

on_worker_boot do
  # Worker specific setup for Rails 4.1+
  # See: https://devcenter.heroku.com/articles/deploying-rails-applications-with-the-puma-web-server#on-worker-boot
  ActiveRecord::Base.establish_connection
end
