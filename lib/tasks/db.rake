namespace :db do
  desc 'Syncs local development database with production'
  task sync: [:environment] do
    Database.sync
  end
end
