uri = ENV['REDISTOGO_URL'] || Settings.redis_url
REDIS = Redis.new(:url => uri)
