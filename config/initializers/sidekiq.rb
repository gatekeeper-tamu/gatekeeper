#'size' is the max number of connections to push jobs to Redis
#regardless of how many threads they have

#here 'client' is our passenger, which is 'puma' running behind 'rails'
#anything that pushes jobs to Redis
Sidekiq.configure_client do |config|
    config.redis = { url: ENV['REDIS_URL'], size: 4, network_timeout: 5 }
end
  
#server is the sidekiq process which pulls jobs from Redis
Sidekiq.configure_server do |config|
    config.redis = { url: ENV['REDIS_URL'], size: 4, network_timeout: 5 }
end