class TrelloWorker
  include Sidekiq::Worker
  sidekiq_options backtrace: true

  def perform
    Service::Trello.sync
  end
end
