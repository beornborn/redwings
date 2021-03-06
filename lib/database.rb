class Database
  def self.sync
    puts 'Syncing local development database with production...'

    db_config = Rails.configuration.database_configuration
    database_name = db_config['development']['database']

    begin
      Bundler.with_clean_env {`heroku pg:backups capture --app redwings`}
      Bundler.with_clean_env {`curl -o latest.dump \`heroku pg:backups public-url --app redwings\``}
      `pg_restore --verbose --clean --no-acl --no-owner --jobs=2 -n public -d #{database_name} latest.dump`
    ensure
      `rm latest.dump`
    end
  end
end

