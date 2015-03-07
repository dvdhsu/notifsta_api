# Fix multiple Sidekiqs running on same server
# http://dev.mensfeld.pl/2014/07/multiple-sidekiq-processes-for-multiple-railssinatra-applications-namespacing/

Sidekiq.configure_server do |config|
  config.redis = {
    url: 'redis://localhost:6379',
    namespace: 'notifsta_webapp'
  }
end
 
Sidekiq.configure_client do |config|
  config.redis = {
    url: 'redis://localhost:6379',
    namespace: 'notifsta_webapp'
  }
end
