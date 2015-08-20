uri = ENV['REDISTOGO_URL'] || Settings.redis.url
REDIS = Redis.new(:url => uri)
