class TrellosyncWorker
  include Sidekiq::Worker

  def perform
    Service::Trello.sync
  end
end
